#!/usr/bin/env bash
#
# DE/sync.sh — pull KDE Plasma config into DE/
#
# Called by repo root sync.sh, or run directly:
#   ./DE/sync.sh
#
set -euo pipefail

# Repo-relative paths — works whether called from root or directly
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { echo "→ [DE] $*"; }
ok()  { echo "✅ [DE] $*"; }

mkdir -p "$SCRIPT_DIR/config" "$SCRIPT_DIR/konsole"

# --- KDE core config ---
KDE_CONFIGS=(
  kdeglobals
  plasmarc
  plasmashellrc
  kwinrc
  kglobalshortcutsrc
  khotkeysrc
  konsolerc
  plasma-org.kde.plasma.desktop-appletsrc
  plasmanotifyrc
  powermanagementprofilesrc
)

for f in "${KDE_CONFIGS[@]}"; do
  src="$HOME/.config/$f"
  dst="$SCRIPT_DIR/config/$f"
  if [[ -f "$src" ]]; then
    cp "$src" "$dst"
    ok "config: $f"
  else
    log "skip (missing): $f"
  fi
done

# --- Konsole profiles + color schemes ---
if [[ -d "$HOME/.local/share/konsole" ]]; then
  shopt -s nullglob
  for f in "$HOME/.local/share/konsole"/*; do
    cp "$f" "$SCRIPT_DIR/konsole/"
    ok "konsole: $(basename "$f")"
  done
  shopt -u nullglob
else
  log "no konsole profiles found"
fi

echo
ok "sync complete → $SCRIPT_DIR"
