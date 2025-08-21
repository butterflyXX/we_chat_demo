#!/usr/bin/env bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export RUBYOPT="-E UTF-8:UTF-8"
export PATH="$HOME/fvm/versions/3.32.8/bin:$PATH"
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
set -euo pipefail

# 极简 Jenkins/Shell 脚本：Flutter Android 打 debug 包 + 蒲公英上传 + 飞书通知

# ==================== 配置区域 ====================
# 蒲公英配置
PGYER_API_KEY="b31a814e617527da3303898b92b779a8"

# 飞书群配置
FEISHU_WEBHOOK_URL="https://open.feishu.cn/open-apis/bot/v2/hook/03937c5e-66d1-47b6-8e75-93eaf9b4d19c"

# 应用信息
APP_NAME="LEION"

# ==================== 函数定义 ====================
# 飞书通知函数
send_feishu_notification() {
    if command -v python3 >/dev/null 2>&1; then
        python3 scripts/notify_feishu.py --title "✅ 构建成功 - ${APP_NAME}" --content "$1" --color "green" --webhook "${FEISHU_WEBHOOK_URL:-}"
    else
        echo "[WARN] 未找到 python3"
        exit 1
    fi
}

# ==================== 主流程 ====================
echo "🚀 开始 Android Debug 构建流程..."
BUILD_START_TIME=$(date '+%Y-%m-%d %H:%M:%S')

echo "[1/5] 环境与依赖检查"
if ! command -v flutter >/dev/null 2>&1; then
  echo "[ERROR] 未检测到 flutter"
  exit 1
fi
flutter --version

# 检查 Android SDK（在 set -u 下使用安全展开，避免未设置时报错）
if [ -z "${ANDROID_HOME:-}" ]; then
  echo "[WARN] 未设置 ANDROID_HOME 环境变量"
  echo "[INFO] 尝试自动检测 Android SDK..."
  if [ -d "$HOME/Library/Android/sdk" ]; then
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    echo "[INFO] 检测到 Android SDK: $ANDROID_HOME"
  elif [ -d "/usr/local/android-sdk" ]; then
    export ANDROID_HOME="/usr/local/android-sdk"
    echo "[INFO] 检测到 Android SDK: $ANDROID_HOME"
  else
    echo "[ERROR] 未找到 Android SDK，请设置 ANDROID_HOME 环境变量"
    exit 1
  fi
fi

# 检查 Java
if ! command -v java >/dev/null 2>&1; then
  echo "[ERROR] 未检测到 Java"
  exit 1
fi
echo "[INFO] Java 版本: $(java -version 2>&1 | head -n 1)"

echo "[2/5] 获取依赖"
flutter pub get

echo "[3/5] 清理构建缓存"
flutter clean

echo "[4/5] 构建 APK (debug)"
flutter build apk --debug

APK_DIR="build/app/outputs/flutter-apk"
echo "[SUCCESS] 导出完成：$APK_DIR"
ls -lh "$APK_DIR" || true

echo "[5/5] 上传到蒲公英"
# 环境变量：
#  - PGYER_API_KEY        (必填) - 蒲公英 API Key
#  - PGYER_PASSWORD       当 INSTALL_TYPE=2 时必填
#  - PGYER_DESC           更新说明（可选）

PGYER_API_KEY="${PGYER_API_KEY:-}"
PGYER_PASSWORD="${PGYER_PASSWORD:-}"
# 使用分支名和最近一次commit信息作为描述
# 优先使用 Jenkins 环境变量，其次从 git 安全探测
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
CANDIDATE_BRANCH="${BRANCH_NAME:-${GIT_BRANCH:-${GIT_LOCAL_BRANCH:-${CHANGE_BRANCH:-}}}}"
if [[ -n "$CANDIDATE_BRANCH" ]]; then
  GIT_BRANCH="$CANDIDATE_BRANCH"
else
  GIT_BRANCH=$(git -C "$REPO_ROOT" symbolic-ref --short -q HEAD 2>/dev/null || true)
  if [[ -z "$GIT_BRANCH" || "$GIT_BRANCH" == "HEAD" ]]; then
    GIT_BRANCH=$(git -C "$REPO_ROOT" for-each-ref --format='%(refname:short)' --contains HEAD refs/heads refs/remotes 2>/dev/null | head -n1 | sed 's#^origin/##' || true)
  fi
  if [[ -z "$GIT_BRANCH" ]]; then
    SHORT_COMMIT=$(git -C "$REPO_ROOT" rev-parse --short HEAD 2>/dev/null || echo "unknown")
    GIT_BRANCH="detached-$SHORT_COMMIT"
  fi
fi
GIT_COMMIT_MSG=$(git -C "$REPO_ROOT" log -1 --pretty=%s 2>/dev/null | tr -d '\n' || echo "no-commit-msg")
PGYER_DESC="${PGYER_DESC:-分支: $GIT_BRANCH, 提交: $GIT_COMMIT_MSG, 构建类型: Debug}"

if [[ -z "$PGYER_API_KEY" ]]; then
  echo "[WARN] 未设置 PGYER_API_KEY，跳过上传蒲公英。"
  exit 0
fi

# 查找 APK 文件
echo "[INFO] 查找 APK 文件..."
find "$APK_DIR" -name "*.apk" -type f 2>/dev/null | head -n 5 || true

APK_PATH=$(find "$APK_DIR" -name "*.apk" -type f 2>/dev/null | head -n 1 || true)
if [[ -z "$APK_PATH" ]]; then
  echo "[ERROR] 未找到 APK 文件，无法上传蒲公英。"
  echo "[DEBUG] 当前目录: $(pwd)"
  echo "[DEBUG] APK目录内容:"
  ls -la "$APK_DIR" || true
  exit 1
fi

echo "[INFO] 找到 APK 文件: $APK_PATH"
echo "[INFO] 文件大小: $(ls -lh "$APK_PATH" | awk '{print $5}')"

# 调试信息
echo "[DEBUG] API Key: ${PGYER_API_KEY:0:8}..."
echo "[DEBUG] Description: $PGYER_DESC"

# 根据蒲公英官方GitHub示例构建请求
PGY_UPLOAD_URL="https://www.pgyer.com/apiv2/app/upload"

# 构建 multipart/form-data 请求 - 使用官方推荐格式
echo "[INFO] 开始上传到蒲公英..."
echo "[DEBUG] 上传URL: $PGY_UPLOAD_URL"

# 根据官方示例，构建正确的参数
CURL_PARAMS=(
  -F "file=@$APK_PATH"
  -F "_api_key=$PGYER_API_KEY"
  -F "buildInstallType=1"
  -F "buildUpdateDescription=$PGYER_DESC"
)

# 使用 curl 上传，确保参数名称正确
echo "[INFO] 执行上传命令..."
echo "[DEBUG] curl 参数: ${CURL_PARAMS[*]}"

# 根据官方示例，添加详细的错误处理和重试机制
MAX_RETRIES=3
RETRY_COUNT=0

while [[ $RETRY_COUNT -lt $MAX_RETRIES ]]; do
  echo "[INFO] 尝试上传 (第 $((RETRY_COUNT + 1)) 次)..."
  
  CURL_RESPONSE=$(curl -sSfL \
    -w "HTTP_STATUS:%{http_code}" \
    -m 300 \
    "${CURL_PARAMS[@]}" \
    "$PGY_UPLOAD_URL")
  
  CURL_CODE=$?
  
  # 分离HTTP状态码和响应内容
  HTTP_STATUS=$(echo "$CURL_RESPONSE" | grep -o "HTTP_STATUS:[0-9]*" | cut -d':' -f2)
  RESPONSE_BODY=$(echo "$CURL_RESPONSE" | sed 's/HTTP_STATUS:[0-9]*//')
  
  # 保存响应到文件
  echo "$RESPONSE_BODY" > "$APK_DIR/pgyer_upload_result.json"
  
  echo "[DEBUG] HTTP状态码: $HTTP_STATUS"
  echo "[DEBUG] 响应内容: $RESPONSE_BODY"
  
  if [[ $CURL_CODE -eq 0 && "$HTTP_STATUS" == "200" ]]; then
    # 检查响应中的错误码
    if echo "$RESPONSE_BODY" | grep -q '"code":0'; then
      echo "[SUCCESS] 蒲公英上传成功！"
      # 提取下载链接
      DOWNLOAD_URL=$(echo "$RESPONSE_BODY" | grep -o '"buildQRCodeURL":"[^"]*"' | cut -d'"' -f4 || echo "")
      BUILD_SHORTCUT_URL=$(echo "$RESPONSE_BODY" | grep -o '"buildShortcutUrl":"[^"]*"' | cut -d'"' -f4 || echo "")
      if [[ -n "$BUILD_SHORTCUT_URL" ]]; then
        DOWNLOAD_PAGE_URL="https://www.pgyer.com/$BUILD_SHORTCUT_URL"
      else
        DOWNLOAD_PAGE_URL="$DOWNLOAD_URL"
      fi
      if [[ -n "$DOWNLOAD_URL" ]]; then
        echo "[INFO] 下载链接: $DOWNLOAD_URL"
      fi
      echo "[SUCCESS] 蒲公英上传完成，结果已保存：$APK_DIR/pgyer_upload_result.json"
      # 仅在成功时发送飞书通知
      SUCCESS_CONTENT="**🎉 Android Debug 构建成功！**\n\n"\
"**应用信息：**\n"\
"• 应用名称：${APP_NAME}（Android Debug）\n"\
"• 构建类型：Debug\n"\
"**下载信息：**\n"\
"• 下载链接：[点击下载]($DOWNLOAD_PAGE_URL)\n"\
"• 描述：$PGYER_DESC\n\n"\
"**构建时间：**\n"\
"• 开始时间：$BUILD_START_TIME\n"\
"• 完成时间：$(date '+%Y-%m-%d %H:%M:%S')"
      send_feishu_notification "$SUCCESS_CONTENT"
      break
    else
      echo "[ERROR] 蒲公英上传失败"
      echo "[ERROR] 错误信息: $RESPONSE_BODY"
      
      # 解析具体错误码
      ERROR_CODE=$(echo "$RESPONSE_BODY" | grep -o '"code":[0-9]*' | cut -d':' -f2 || echo "unknown")
      ERROR_MSG=$(echo "$RESPONSE_BODY" | grep -o '"message":"[^"]*"' | cut -d'"' -f4 || echo "unknown error")
      
      echo "[ERROR] 错误码: $ERROR_CODE"
      echo "[ERROR] 错误消息: $ERROR_MSG"
      
      # 根据蒲公英官方错误码提供解决建议
      case $ERROR_CODE in
        1212)
          echo "[SUGGESTION] 错误码 1212: 渠道短链接无效，请检查短链接"
          echo "[SUGGESTION] 解决方案："
          echo "[SUGGESTION] 1. 先在蒲公英平台手动上传一次应用，创建应用记录"
          echo "[SUGGESTION] 2. 确认 API Key 有上传权限"
          echo "[SUGGESTION] 3. 检查应用状态是否正常"
          echo "[SUGGESTION] 4. 参考官方示例：https://github.com/PGYER/upload-app-api-example"
          ;;
        1001)
          echo "[SUGGESTION] 错误码 1001: API Key 无效"
          echo "[SUGGESTION] 请检查 API Key 是否正确"
          ;;
        1002)
          echo "[SUGGESTION] 错误码 1002: API Key 未找到"
          echo "[SUGGESTION] 请检查 API Key 是否正确设置"
          ;;
        1003)
          echo "[SUGGESTION] 错误码 1003: 应用不存在"
          echo "[SUGGESTION] 请先在蒲公英平台创建应用"
          ;;
        1098)
          echo "[SUGGESTION] 错误码 1098: API 请求达到每小时的上限"
          echo "[SUGGESTION] 请稍后再试或升级账户"
          ;;
        1097)
          echo "[SUGGESTION] 错误码 1097: 签名错误"
          echo "[SUGGESTION] 请检查 APK 文件签名是否正确"
          ;;
        *)
          echo "[SUGGESTION] 未知错误码，请查看蒲公英官方文档获取更多信息"
          echo "[SUGGESTION] 官方示例：https://github.com/PGYER/upload-app-api-example"
          ;;
      esac
      
      # 如果是可重试的错误，继续重试
      if [[ "$ERROR_CODE" == "1098" || "$ERROR_CODE" == "1001" || "$ERROR_CODE" == "1002" ]]; then
        RETRY_COUNT=$((RETRY_COUNT + 1))
        if [[ $RETRY_COUNT -lt $MAX_RETRIES ]]; then
          echo "[INFO] 等待 10 秒后重试..."
          sleep 10
          continue
        fi
      fi
      
      exit 1
    fi
  else
    echo "[ERROR] 网络请求失败 (curl code=$CURL_CODE, HTTP status=$HTTP_STATUS)"
    RETRY_COUNT=$((RETRY_COUNT + 1))
    
    if [[ $RETRY_COUNT -lt $MAX_RETRIES ]]; then
      echo "[INFO] 等待 10 秒后重试..."
      sleep 10
    else
      echo "[ERROR] 达到最大重试次数，上传失败"
      exit 1
    fi
  fi
done

echo "🎉 Android Debug 构建流程完成！"

# ==================== 使用说明 ====================
echo ""
echo "📖 使用说明："
echo "  1. 配置蒲公英参数："
echo "     - PGYER_API_KEY: 在蒲公英开发者中心获取"
echo "     - 注意：安装类型固定为公开安装，安装时间固定为永久"
echo ""
echo "  2. 配置飞书通知："
echo "     - FEISHU_WEBHOOK_URL: 飞书群机器人 Webhook 地址"
echo ""
echo "  3. 运行脚本："
echo "     ./android_debug_build.sh"
echo ""
echo "🔗 相关链接："
echo "  - 蒲公英 API 文档: https://www.pgyer.com/doc/view/api"
echo "  - 飞书机器人配置: https://open.feishu.cn/document/ukTMukTMukTM/ucTM5YjL3ETO24yNxkjN"
