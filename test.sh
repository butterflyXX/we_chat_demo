#!/usr/bin/env bash
set -euo pipefail

# 极简 Jenkins/Shell 脚本：Flutter iOS 打 development 包（自动签名）
# teamID 已写死为 QGYHTE2J6P
# 可选：FLUTTER_CHANNEL（默认 stable）

FLUTTER_CHANNEL="${FLUTTER_CHANNEL:-stable}"
DEVELOPMENT_TEAM="QGYHTE2J6P"

echo "[1/4] 环境与依赖检查"
if ! command -v flutter >/dev/null 2>&1; then
  echo "[INFO] 未检测到 flutter，开始安装到 ~/flutter"
  git clone https://github.com/flutter/flutter.git -b "$FLUTTER_CHANNEL" "$HOME/flutter"
  export PATH="$HOME/flutter/bin:$PATH"
fi
flutter --version

# CocoaPods（节点若已装可跳过）
if ! command -v pod >/dev/null 2>&1; then
  echo "[INFO] 未检测到 cocoapods，请先在构建机安装：sudo gem install cocoapods" >&2
  exit 1
fi

echo "[2/4] 获取依赖"
flutter pub get
pushd ios >/dev/null
pod install --verbose
popd >/dev/null

echo "[3/4] 生成导出配置 (ExportOptions.plist)"
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
  <string>${DEVELOPMENT_TEAM}</string>
  <key>destination</key>
  <string>export</string>
  <key>stripSwiftSymbols</key>
  <true/>
  <key>compileBitcode</key>
  <false/>
</dict>
</plist>
EOF

echo "[4/4] 构建 IPA (development)"
# 使用 Release 配置 + development 导出方式，Xcode 自动签名
# 若工程未开启自动签名，请在 Xcode 打开 Runner 工程 -> Signing & Capabilities 启用
flutter clean
flutter build ipa \
  --export-options-plist="$EXPORT_PLIST" \
  --release

IPA_DIR="build/ios/ipa"
echo "[DONE] 导出完成：$IPA_DIR"
ls -lh "$IPA_DIR" || true
