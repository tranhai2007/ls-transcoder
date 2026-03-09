#!/usr/bin/env bash
set -e

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ] || [ "$ARCH" = "amd64" ]; then
    TARGETARCH="amd64"
elif [ "$ARCH" = "arm64" ] || [ "$ARCH" = "aarch64" ]; then
    TARGETARCH="arm64"
else
    echo "Unsupported arch: $ARCH"
    exit 1
fi

echo "Detected architecture: $TARGETARCH"

# 固定版本号为 1.19.6
TARGET_VERSION="1.19.6"
echo "Target version: $TARGET_VERSION (Fixed)"

WORKDIR="/tmp/antigravity-extract-$$"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# Mac & Linux compatible extraction
if [ "$TARGETARCH" = "amd64" ]; then
    echo "Fetching latest amd64 DEB package URL..."
    if [ "$TARGET_VERSION" = "latest" ]; then
        PKG_PATH=$(curl -s https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/dists/antigravity-debian/main/binary-amd64/Packages | awk '/^Package:/ { if($2=="antigravity") { p=1 } else { p=0 } } p && /^Filename:/ {print $2; exit}')
    else
        PKG_PATH=$(curl -s https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/dists/antigravity-debian/main/binary-amd64/Packages | awk -v v="$TARGET_VERSION" '/^Package:/ { if($2=="antigravity") { p=1 } else { p=0 } } p && /^Version:/ { if($2 ~ "^"v) { v_match=1 } else { v_match=0 } } p && v_match && /^Filename:/ {print $2; exit}')
    fi
    DEB_URL="https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/${PKG_PATH}"
    
    echo "Downloading DEB: $DEB_URL"
    curl -sL "$DEB_URL" -o antigravity.deb
    
    echo "Extracting DEB..."
    ar x antigravity.deb
    tar xf data.tar.xz
    
    LS_BIN="usr/share/antigravity/resources/app/extensions/antigravity/bin/language_server_linux_x64"
    CERT_FILE="usr/share/antigravity/resources/app/extensions/antigravity/dist/languageServer/cert.pem"

elif [ "$TARGETARCH" = "arm64" ]; then
    echo "Downloading ARM64 tar.gz..."
    # 修正：使用 64 位 ARM 二进制链接 (从官方最新 deb 提取或直接指向 arm64 镜像)
    # 之前报错是因为下载了 linux-arm (32位)，我们要的是 linux-arm64 (64位)
    # 这里我们采用与 amd64 类似的 DEB 提取逻辑，但指向 arm64 仓库
    echo "Fetching latest arm64 DEB package URL..."
    if [ "$TARGET_VERSION" = "latest" ]; then
        PKG_PATH=$(curl -s https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/dists/antigravity-debian/main/binary-arm64/Packages | awk '/^Package:/ { if($2=="antigravity") { p=1 } else { p=0 } } p && /^Filename:/ {print $2; exit}')
    else
        PKG_PATH=$(curl -s https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/dists/antigravity-debian/main/binary-arm64/Packages | awk -v v="$TARGET_VERSION" '/^Package:/ { if($2=="antigravity") { p=1 } else { p=0 } } p && /^Version:/ { if($2 ~ "^"v) { v_match=1 } else { v_match=0 } } p && v_match && /^Filename:/ {print $2; exit}')
    fi
    DEB_URL="https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/${PKG_PATH}"
    
    echo "Downloading DEB: $DEB_URL"
    curl -sL "$DEB_URL" -o antigravity.deb
    
    echo "Extracting DEB..."
    ar x antigravity.deb
    tar xf data.tar.xz
    
    LS_BIN="usr/share/antigravity/resources/app/extensions/antigravity/bin/language_server_linux_arm"
    CERT_FILE="usr/share/antigravity/resources/app/extensions/antigravity/dist/languageServer/cert.pem"
fi

echo "Copying to target directory..."
DEST_DIR="${OLDPWD}/bin"
mkdir -p "$DEST_DIR"

cp "$LS_BIN" "$DEST_DIR/ls_core"
cp "$CERT_FILE" "$DEST_DIR/cert.pem"
chmod +x "$DEST_DIR/ls_core"

# Clean up
cd "$OLDPWD"
rm -rf "$WORKDIR"

echo "Successfully extracted ls_core and cert.pem (v1.19.6) to $DEST_DIR"
