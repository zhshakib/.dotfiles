#!/usr/bin/env bash
#
# sync.sh — repo-root orchestrator
#
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure every sync script (including this one) is executable
find "$REPO_DIR" -maxdepth 2 -type f -name 'sync.sh' -exec chmod +x {} +

# List of subfolders that have their own sync.sh
SUBSYNC_DIRS=(
  DE
  terminal
  # apps
  # system
)

echo "🔄 Syncing dotfiles → $REPO_DIR"
echo

failures=0

for dir in "${SUBSYNC_DIRS[@]}"; do
  script="$REPO_DIR/$dir/sync.sh"

  if [[ ! -f "$script" ]]; then
    echo "⏭  skip: $dir/ (no sync.sh)"
    continue
  fi

  if [[ ! -x "$script" ]]; then
    chmod +x "$script"
  fi

  echo "▶ $dir"
  if ! "$script"; then
    echo "❌ $dir failed"
    failures=$((failures + 1))
  fi
  echo
done

if [[ $failures -gt 0 ]]; then
  echo "⚠️  $failures sub-sync(s) failed"
  exit 1
fi

echo "✅ all syncs complete"
echo
echo "Next:"
echo "  git add ."
echo "  git diff --cached --stat"
echo "  git commit -m 'sync: update dotfiles'"
echo "  git push"
