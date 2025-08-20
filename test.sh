#!/usr/bin/env bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export RUBYOPT="-E UTF-8:UTF-8"
set -euo pipefail

# 极简 Jenkins/Shell 脚本：Flutter iOS 打 development 包（自动签名）+ 蒲公英上传 + 飞书通知

# ==================== 配置区域 ====================
# 蒲公英配置
PGYER_API_KEY="b31a814e617527da3303898b92b779a8"

# 蒲公英上传配置
PGYER_BUILD_NAME="LEION"           # 构建名称，留空则自动生成
PGYER_BUILD_DESCRIPTION="LEION"    # 构建描述，留空则自动生成
PGYER_CHANNEL_SHORTCUT="iOS"  # 渠道标识，默认default
PGYER_INSTALL_TYPE="1"        # 安装类型：固定为1=公开安装
PGYER_INSTALL_DATE="4"        # 安装时间限制：固定为4=永久

# 飞书群配置
FEISHU_WEBHOOK_URL="https://open.feishu.cn/open-apis/bot/v2/hook/f47621f7-3cb6-4ffa-a2b0-0a51e7891a02"
FEISHU_BOT_NAME="构建机器人"

# 应用信息
APP_NAME="LEION"
APP_VERSION="1.0.0"
BUILD_NUMBER="1"

# ==================== 函数定义 ====================
# 飞书通知函数
send_feishu_notification() {
    local title="$1"
    local content="$2"
    local color="$3"  # 绿色/红色/蓝色
    
    local message="{
        \"msg_type\": \"interactive\",
        \"card\": {
            \"config\": {
                \"wide_screen_mode\": true
            },
            \"header\": {
                \"title\": {
                    \"tag\": \"plain_text\",
                    \"content\": \"$title\"
                },
                \"template\": \"$color\"
            },
            \"elements\": [
                {
                    \"tag\": \"div\",
                    \"text\": {
                        \"tag\": \"lark_md\",
                        \"content\": \"$content\"
                    }
                }
            ]
        }
    }"
    
    if [ -n "$FEISHU_WEBHOOK_URL" ] && [ "$FEISHU_WEBHOOK_URL" != "your_feishu_webhook_url_here" ]; then
        echo "[INFO] 发送飞书通知..."
        curl -X POST -H "Content-Type: application/json" \
             -d "$message" \
             "$FEISHU_WEBHOOK_URL" || echo "[WARN] 飞书通知发送失败"
    else
        echo "[INFO] 飞书通知未配置，跳过"
    fi
}

# 蒲公英上传函数
upload_to_pgyer() {
    local ipa_path="$1"
    
    echo "[INFO] 开始上传到蒲公英..."
    
    # 构建上传参数 - 使用最新的API 2.0接口
    local upload_url="https://www.pgyer.com/apiv2/app/upload"
    
    # 构建名称：优先使用配置，否则自动生成
    local build_name=$PGYER_BUILD_NAME
    
    # 安装类型和密码
    local build_install_type=$PGYER_INSTALL_TYPE
    
    # 构建描述：优先使用配置，否则自动生成
    local build_update_description=$PGYER_BUILD_DESCRIPTION
    
    # 渠道和安装时间限制
    local build_channel_shortcut=$PGYER_CHANNEL_SHORTCUT
    local build_install_date=$PGYER_INSTALL_DATE
    
    # 上传到蒲公英 - 使用API 2.0格式
    local response=$(curl -s -F "file=@$ipa_path" \
        -F "_api_key=$PGYER_API_KEY" \
        -F "buildName=$build_name" \
        -F "buildInstallType=$build_install_type" \
        -F "buildUpdateDescription=$build_update_description" \
        -F "buildChannelShortcut=$build_channel_shortcut" \
        -F "buildInstallDate=$build_install_date" \
        "$upload_url")
    
    # 解析响应 - 根据API 2.0响应格式
    local code=$(echo "$response" | grep -o '"code":[0-9]*' | cut -d':' -f2)
    local message=$(echo "$response" | grep -o '"message":"[^"]*"' | cut -d'"' -f4)
    
    if [ "$code" = "0" ]; then
        # 解析成功响应的详细信息
        local data=$(echo "$response" | grep -o '"data":{[^}]*}' | sed 's/"data":{//' | sed 's/}$//')
        
        # 提取关键信息
        local build_key=$(echo "$data" | grep -o '"buildKey":"[^"]*"' | cut -d'"' -f4)
        local build_type=$(echo "$data" | grep -o '"buildType":"[^"]*"' | cut -d'"' -f4)
        local build_is_forced=$(echo "$data" | grep -o '"buildIsFirst":"[^"]*"' | cut -d'"' -f4)
        local build_is_lastest=$(echo "$data" | grep -o '"buildIsLastest":"[^"]*"' | cut -d'"' -f4)
        local build_file_size=$(echo "$data" | grep -o '"buildFileSize":"[^"]*"' | cut -d'"' -f4)
        local build_name=$(echo "$data" | grep -o '"buildName":"[^"]*"' | cut -d'"' -f4)
        local build_version=$(echo "$data" | grep -o '"buildVersion":"[^"]*"' | cut -d'"' -f4)
        local build_version_no=$(echo "$data" | grep -o '"buildVersionNo":"[^"]*"' | cut -d'"' -f4)
        local build_build_version=$(echo "$data" | grep -o '"buildBuildVersion":"[^"]*"' | cut -d'"' -f4)
        local build_identifier=$(echo "$data" | grep -o '"buildIdentifier":"[^"]*"' | cut -d'"' -f4)
        local build_icon=$(echo "$data" | grep -o '"buildIcon":"[^"]*"' | cut -d'"' -f4)
        local build_description=$(echo "$data" | grep -o '"buildDescription":"[^"]*"' | cut -d'"' -f4)
        local build_update_description=$(echo "$data" | grep -o '"buildUpdateDescription":"[^"]*"' | cut -d'"' -f4)
        local build_screen_shot=$(echo "$data" | grep -o '"buildScreenShot":"[^"]*"' | cut -d'"' -f4)
        local build_shortcut_url=$(echo "$data" | grep -o '"buildShortcutUrl":"[^"]*"' | cut -d'"' -f4)
        local build_created=$(echo "$data" | grep -o '"buildCreated":"[^"]*"' | cut -d'"' -f4)
        local build_updated=$(echo "$data" | grep -o '"buildUpdated":"[^"]*"' | cut -d'"' -f4)
        local build_QR_codeURL=$(echo "$data" | grep -o '"buildQRCodeURL":"[^"]*"' | cut -d'"' -f4)
        
        echo "[SUCCESS] 蒲公英上传成功！"
        echo "  - 应用名称: $build_name"
        echo "  - 版本号: $build_version ($build_version_no)"
        echo "  - 构建版本: $build_build_version"
        echo "  - 文件大小: $build_file_size"
        echo "  - 下载链接: https://www.pgyer.com/$build_shortcut_url"
        echo "  - 二维码: $build_QR_codeURL"
        
        # 发送成功通知到飞书
        local success_content="**🎉 构建成功！**\n\n"\
"**应用信息：**\n"\
"• 应用名称：$build_name\n"\
"• 版本号：$build_version ($build_version_no)\n"\
"• 构建版本：$build_build_version\n"\
"• 文件大小：$build_file_size\n\n"\
"**下载信息：**\n"\
"• 下载链接：[点击下载](https://www.pgyer.com/$build_shortcut_url)\n"\
"• 二维码：[查看二维码]($build_QR_codeURL)\n\n"\
"**构建时间：**\n"\
"• 开始时间：$BUILD_START_TIME\n"\
"• 完成时间：$(date '+%Y-%m-%d %H:%M:%S')\n"\
"• 构建环境：$(uname -s) $(uname -m)"
        
        send_feishu_notification "✅ 构建成功 - $APP_NAME" "$success_content" "green"
        
        return 0
    else
        echo "[ERROR] 蒲公英上传失败: $message"
        echo "[ERROR] 响应内容: $response"
        
        # 发送失败通知到飞书
        local error_content="**❌ 构建失败！**\n\n"\
"**错误信息：**\n"\
"• 蒲公英上传失败\n"\
"• 错误代码：$code\n"\
"• 错误描述：$message\n\n"\
"**构建信息：**\n"\
"• 应用名称：$APP_NAME\n"\
"• 版本号：$APP_VERSION\n"\
"• 构建编号：$BUILD_NUMBER\n\n"\
"**时间信息：**\n"\
"• 开始时间：$BUILD_START_TIME\n"\
"• 失败时间：$(date '+%Y-%m-%d %H:%M:%S')"
        
        send_feishu_notification "❌ 构建失败 - $APP_NAME" "$error_content" "red"
        
        return 1
    fi
}

# 读取版本信息
read_version_info() {
    if [ -f "pubspec.yaml" ]; then
        echo "[INFO] 读取版本信息..."
        APP_VERSION=$(grep "^version:" pubspec.yaml | sed 's/version: //' | tr -d ' ')
        BUILD_NUMBER=$(grep "^version:" pubspec.yaml | sed 's/version: //' | tr -d ' ' | cut -d'+' -f2)
        echo "  - 版本号: $APP_VERSION"
        echo "  - 构建号: $BUILD_NUMBER"
    fi
}

# ==================== 主流程 ====================
echo "🚀 开始构建流程..."
BUILD_START_TIME=$(date '+%Y-%m-%d %H:%M:%S')

# 读取版本信息
read_version_info

echo "[1/5] 环境与依赖检查"
if ! command -v flutter >/dev/null 2>&1; then
  echo "[ERROR] 未检测到 flutter"
  send_feishu_notification "❌ 构建失败 - $APP_NAME" "**环境检查失败**\n\n• 未检测到 Flutter 环境\n• 请检查 Flutter 是否正确安装" "red"
  exit 1
fi
flutter --version

# CocoaPods（节点若已装可跳过）
if ! command -v pod >/dev/null 2>&1; then
  echo "[ERROR] 未检测到 cocoapods，请先在构建机安装：sudo gem install cocoapods" >&2
  send_feishu_notification "❌ 构建失败 - $APP_NAME" "**环境检查失败**\n\n• 未检测到 CocoaPods\n• 请执行：sudo gem install cocoapods" "red"
  exit 1
fi

echo "[2/5] 获取依赖"
flutter pub get
pushd ios >/dev/null
pod install --verbose
popd >/dev/null

echo "[3/5] 生成导出配置 (ExportOptions.plist)"
EXPORT_PLIST="ios/ExportOptions.plist"
cat > "$EXPORT_PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>method</key>
  <string>development</string>
  <key>signingStyle</key>
  <string>automatic</string>
  <key>teamID</key>
  <string>QGYHTE2J6P</string>
  <key>destination</key>
  <string>export</string>
  <key>stripSwiftSymbols</key>
  <true/>
  <key>compileBitcode</key>
  <false/>
</dict>
</plist>
EOF

echo "[4/5] 构建 IPA (development)"
# 使用 Release 配置 + development 导出方式，Xcode 自动签名
# 若工程未开启自动签名，请在 Xcode 打开 Runner 工程 -> Signing & Capabilities 启用
flutter clean
flutter build ipa \
  --export-options-plist="$EXPORT_PLIST" \
  --release

IPA_DIR="build/ios/ipa"
echo "[SUCCESS] 导出完成：$IPA_DIR"
ls -lh "$IPA_DIR" || true

echo "[5/5] 上传到蒲公英"
# 环境变量：
#  - PGYER_API_KEY        (必填) - 蒲公英 API Key
#  - PGYER_INSTALL_TYPE   1公开 / 2密码 / 3邀请 (默认1)
#  - PGYER_PASSWORD       当 INSTALL_TYPE=2 时必填
#  - PGYER_DESC           更新说明（可选）

PGYER_API_KEY="${PGYER_API_KEY:-}"
PGYER_INSTALL_TYPE="${PGYER_INSTALL_TYPE:-1}"
PGYER_PASSWORD="${PGYER_PASSWORD:-}"
PGYER_DESC="${PGYER_DESC:-Auto upload at $(date '+%Y-%m-%d %H:%M:%S')}"

if [[ -z "$PGYER_API_KEY" ]]; then
  echo "[WARN] 未设置 PGYER_API_KEY，跳过上传蒲公英。"
  exit 0
fi

# 查找 IPA 文件
echo "[INFO] 查找 IPA 文件..."
find "$IPA_DIR" -name "*.ipa" -type f 2>/dev/null | head -n 5 || true

IPA_PATH=$(find "$IPA_DIR" -name "*.ipa" -type f 2>/dev/null | head -n 1 || true)
if [[ -z "$IPA_PATH" ]]; then
  echo "[ERROR] 未找到 IPA 文件，无法上传蒲公英。"
  echo "[DEBUG] 当前目录: $(pwd)"
  echo "[DEBUG] IPA目录内容:"
  ls -la "$IPA_DIR" || true
  exit 1
fi

echo "[INFO] 找到 IPA 文件: $IPA_PATH"
echo "[INFO] 文件大小: $(ls -lh "$IPA_PATH" | awk '{print $5}')"

# 调试信息
echo "[DEBUG] API Key: ${PGYER_API_KEY:0:8}..."
echo "[DEBUG] Install Type: $PGYER_INSTALL_TYPE"
echo "[DEBUG] Description: $PGYER_DESC"

# 根据蒲公英官方GitHub示例构建请求
PGY_UPLOAD_URL="https://www.pgyer.com/apiv2/app/upload"

# 构建 multipart/form-data 请求 - 使用官方推荐格式
echo "[INFO] 开始上传到蒲公英..."
echo "[DEBUG] 上传URL: $PGY_UPLOAD_URL"

# 根据官方示例，构建正确的参数
CURL_PARAMS=(
  -F "file=@$IPA_PATH"
  -F "_api_key=$PGYER_API_KEY"
  -F "buildInstallType=$PGYER_INSTALL_TYPE"
  -F "buildUpdateDescription=$PGYER_DESC"
)

# 只有当安装类型为密码安装时才添加密码参数
if [[ "$PGYER_INSTALL_TYPE" == "2" && -n "$PGYER_PASSWORD" ]]; then
  CURL_PARAMS+=( -F "buildPassword=$PGYER_PASSWORD" )
fi

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
  echo "$RESPONSE_BODY" > "$IPA_DIR/pgyer_upload_result.json"
  
  echo "[DEBUG] HTTP状态码: $HTTP_STATUS"
  echo "[DEBUG] 响应内容: $RESPONSE_BODY"
  
  if [[ $CURL_CODE -eq 0 && "$HTTP_STATUS" == "200" ]]; then
    # 检查响应中的错误码
    if echo "$RESPONSE_BODY" | grep -q '"code":0'; then
      echo "[SUCCESS] 蒲公英上传成功！"
      # 提取下载链接
      DOWNLOAD_URL=$(echo "$RESPONSE_BODY" | grep -o '"buildQRCodeURL":"[^"]*"' | cut -d'"' -f4 || echo "")
      if [[ -n "$DOWNLOAD_URL" ]]; then
        echo "[INFO] 下载链接: $DOWNLOAD_URL"
      fi
      echo "[SUCCESS] 蒲公英上传完成，结果已保存：$IPA_DIR/pgyer_upload_result.json"
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
          echo "[SUGGESTION] 请检查 IPA 文件签名是否正确"
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

echo "🎉 构建流程完成！"
echo "  - IPA 文件: $IPA_FILE"
echo "  - 构建时间: $BUILD_START_TIME -> $(date '+%Y-%m-%d %H:%M:%S')"

# ==================== 使用说明 ====================
echo ""
echo "📖 使用说明："
echo "  1. 配置蒲公英参数："
echo "     - PGYER_API_KEY: 在蒲公英开发者中心获取"
echo "     - PGYER_BUILD_NAME: 自定义构建名称（可选）"
echo "     - PGYER_BUILD_DESCRIPTION: 构建描述（可选）"
echo "     - PGYER_CHANNEL_SHORTCUT: 渠道标识（可选）"
echo "     - 注意：安装类型固定为公开安装，安装时间固定为永久"
echo ""
echo "  2. 配置飞书通知："
echo "     - FEISHU_WEBHOOK_URL: 飞书群机器人 Webhook 地址"
echo ""
echo "  3. 运行脚本："
echo "     ./build.sh"
echo ""
echo "🔗 相关链接："
echo "  - 蒲公英 API 文档: https://www.pgyer.com/doc/view/api"
echo "  - 飞书机器人配置: https://open.feishu.cn/document/ukTMukTMukTM/ucTM5YjL3ETO24yNxkjN"