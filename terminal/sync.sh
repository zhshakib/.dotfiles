#!/usr/bin/env bash
#
# terminal/sync.sh — pull shell + terminal config into terminal/
#
# Called by repo root sync.sh, or run directly:
#   ./terminal/sync.sh
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { echo "→ [terminal] $*"; }
ok()  { echo "✅ [terminal] $*"; }

mkdir -p "$SCRIPT_DIR"

# --- Zsh ---
if [[ -f "$HOME/.zshrc" ]]; then
  cp "$HOME/.zshrc" "$SCRIPT_DIR/zshrc"
  ok "zshrc"
else
  log "skip (missing): ~/.zshrc"
fi

# --- Starship prompt ---
if [[ -f "$HOME/.config/starship.toml" ]]; then
  cp "$HOME/.config/starship.toml" "$SCRIPT_DIR/starship.toml"
  ok "starship.toml"
else
  log "skip (missing): ~/.config/starship.toml"
fi

# --- Konsole Starship colorscheme ---
if [[ -f "$HOME/.local/share/konsole/Starship.colorscheme" ]]; then
  cp "$HOME/.local/share/konsole/Starship.colorscheme" "$SCRIPT_DIR/Starship.colorscheme"
  ok "Starship.colorscheme"
else
  log "skip (missing): ~/.local/share/konsole/Starship.colorscheme"
fi

echo
ok "sync complete → $SCRIPT_DIR"
