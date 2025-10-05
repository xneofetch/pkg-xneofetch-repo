#!/bin/bash

REPO_DIR="./repo"
INSTALL_DIR="$HOME/.local/bin"  # Burayı ihtiyaca göre değiştirebilirsin
INSTALLED_DB="./installed.db"

function usage() {
    echo "Usage:"
    echo "  $0 -S package_name   # install package"
    echo "  $0 -R package_name   # remove package"
    echo "  $0 -L               # list installed packages"
    exit 1
}

function is_installed() {
    grep -q "^$1$" "$INSTALLED_DB"
}

function install_pkg() {
    local pkg=$1
    local pkg_dir="$REPO_DIR/$pkg"

    if [ ! -d "$pkg_dir" ]; then
        echo "Package '$pkg' not found in repo."
        exit 1
    fi

    if is_installed "$pkg"; then
        echo "Package '$pkg' is already installed."
        exit 0
    fi

    # Paket script dosyasını /usr/local/bin'e kopyala
    cp "$pkg_dir/$pkg.sh" "$INSTALL_DIR/$pkg"
    chmod +x "$INSTALL_DIR/$pkg"

    # installed.db dosyasına ekle
    echo "$pkg" >> "$INSTALLED_DB"
    echo "Package '$pkg' installed successfully."
}

function remove_pkg() {
    local pkg=$1
    local install_path="$INSTALL_DIR/$pkg"

    if ! is_installed "$pkg"; then
        echo "Package '$pkg' is not installed."
        exit 1
    fi

    rm -f "$install_path"
    sed -i "/^$pkg$/d" "$INSTALLED_DB"
    echo "Package '$pkg' removed successfully."
}

function list_pkgs() {
    if [ ! -s "$INSTALLED_DB" ]; then
        echo "No packages installed."
        exit 0
    fi
    echo "Installed packages:"
    cat "$INSTALLED_DB"
}

if [ $# -eq 0 ]; then
    usage
fi

case "$1" in
    -S)
        [ -z "$2" ] && usage
        install_pkg "$2"
        ;;
    -R)
        [ -z "$2" ] && usage
        remove_pkg "$2"
        ;;
    -L)
        list_pkgs
        ;;
    *)
        usage
        ;;
esac
