#!/usr/bin/env bash
#
# apps/sync.sh
#
# Backup application configurations
#

set -euo pipefail


REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"


echo "📦 Syncing applications..."


copy_config() {
    local source="$1"
    local destination="$2"

    if [[ -e "$source" ]]; then
        mkdir -p "$(dirname "$destination")"
        cp -r "$source" "$destination"
        echo "  ✅ $(basename "$source")"
    else
        echo "  ⏭ missing: $source"
    fi
}


# ============================================================
# VS Code
# ============================================================

echo
echo "󰨞 VS Code"

copy_config \
    "$HOME_DIR/.config/Code/User/settings.json" \
    "$REPO_DIR/vscode/settings.json"


# ============================================================
# Rofi
# ============================================================

echo
echo "󰕮 Rofi"

copy_config \
    "$HOME_DIR/.config/rofi" \
    "$REPO_DIR/rofi"


# ============================================================
# Firefox
# ============================================================

echo
echo "󰈹 Firefox"

FIREFOX_DIR="$HOME_DIR/.mozilla/firefox"

if [[ -d "$FIREFOX_DIR" ]]; then

    mkdir -p "$REPO_DIR/firefox"

    cp -r \
        "$FIREFOX_DIR"/*/chrome \
        "$REPO_DIR/firefox/" 2>/dev/null || true

    echo "  ✅ Firefox chrome"

else

    echo "  ⏭ Firefox profile not found"

fi


echo
echo "✅ Application sync complete"