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

WORKDIR="/tmp/antigravity-extract-$$"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# Mac & Linux compatible extraction
if [ "$TARGETARCH" = "amd64" ]; then
    echo "Fetching latest amd64 DEB package URL..."
    PKG_PATH=$(curl -s https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/dists/antigravity-debian/main/binary-amd64/Packages | awk '/^Package:/ { if($2=="antigravity") { p=1 } else { p=0 } } p && /^Filename:/ {print $2; exit}')
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
    # Used the URL from the Dockerfile snippet the user provided
    TAR_URL="https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/1.18.3-4739469533380608/linux-arm/Antigravity.tar.gz"
    curl -sL "$TAR_URL" -o antigravity.tar.gz
    
    echo "Extracting tar.gz..."
    tar xzf antigravity.tar.gz
    
    LS_BIN="Antigravity/resources/app/extensions/antigravity/bin/language_server_linux_arm"
    CERT_FILE="Antigravity/resources/app/extensions/antigravity/dist/languageServer/cert.pem"
fi

echo "Copying to target directory..."
DEST_DIR="${OLDPWD}/core-bin"
mkdir -p "$DEST_DIR"

cp "$LS_BIN" "$DEST_DIR/ls_binary"
cp "$CERT_FILE" "$DEST_DIR/cert.pem"
chmod +x "$DEST_DIR/ls_binary"

# Clean up
cd "$OLDPWD"
rm -rf "$WORKDIR"

echo "Successfully extracted ls_binary and cert.pem to $DEST_DIR"
