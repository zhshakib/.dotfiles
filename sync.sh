#!/usr/bin/env bash

# ============================================================
# Dotfiles Sync
# Sync live configuration files into ~/dotfiles
# ============================================================

set -u

# ------------------------------------------------------------
# Paths
# ------------------------------------------------------------

DOTFILES_DIR="$HOME/dotfiles"

FILES=(
    "$HOME/.zshrc|$DOTFILES_DIR/terminal/.zshrc"
    "$HOME/.config/starship.toml|$DOTFILES_DIR/terminal/starship.toml"
    "$HOME/.local/share/konsole/Starship.colorscheme|$DOTFILES_DIR/terminal/Starship.colorscheme"
)

# ------------------------------------------------------------
# Colors
# ------------------------------------------------------------

RESET='\033[0m'
BOLD='\033[1m'

GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
BLUE='\033[34m'
CYAN='\033[36m'
DIM='\033[2m'

# ------------------------------------------------------------
# Counters
# ------------------------------------------------------------

CHECKED=0
UPDATED=0
UNCHANGED=0
MISSING=0

# ------------------------------------------------------------
# Helpers
# ------------------------------------------------------------

print_header() {
    echo
    printf "${BOLD}${CYAN}Dotfiles sync${RESET}\n"
    printf "${DIM}────────────────────────────────────────${RESET}\n"
}

sync_file() {
    local source="$1"
    local destination="$2"

    ((CHECKED++))

    # Source file doesn't exist
    if [[ ! -f "$source" ]]; then
        printf "${RED}✗${RESET} %-25s ${DIM}source not found${RESET}\n" \
            "$(basename "$source")"

        ((MISSING++))
        return
    fi

    # Create destination directory if necessary
    mkdir -p "$(dirname "$destination")"

    # Destination doesn't exist
    if [[ ! -f "$destination" ]]; then
        cp "$source" "$destination"

        printf "${BLUE}↑${RESET} %-25s ${BLUE}added${RESET}\n" \
            "$(basename "$source")"

        ((UPDATED++))
        return
    fi

    # Files are identical
    if cmp -s "$source" "$destination"; then
        printf "${GREEN}✓${RESET} %-25s ${DIM}unchanged${RESET}\n" \
            "$(basename "$source")"

        ((UNCHANGED++))
        return
    fi

    # Files differ
    cp "$source" "$destination"

    printf "${YELLOW}↑${RESET} %-25s ${YELLOW}updated${RESET}\n" \
        "$(basename "$source")"

    ((UPDATED++))
}

# ------------------------------------------------------------
# Start
# ------------------------------------------------------------

print_header

for entry in "${FILES[@]}"; do
    IFS='|' read -r source destination <<< "$entry"
    sync_file "$source" "$destination"
done

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------

echo
printf "${DIM}────────────────────────────────────────${RESET}\n"

printf "${BOLD}%d${RESET} files checked\n" "$CHECKED"

if ((UPDATED > 0)); then
    printf "${YELLOW}%d${RESET} file(s) updated\n" "$UPDATED"
fi

if ((UNCHANGED > 0)); then
    printf "${GREEN}%d${RESET} file(s) unchanged\n" "$UNCHANGED"
fi

if ((MISSING > 0)); then
    printf "${RED}%d${RESET} source file(s) missing\n" "$MISSING"
fi

echo

if ((UPDATED > 0)); then
    printf "${DIM}Review changes with:${RESET}\n"
    printf "  git -C \"$DOTFILES_DIR\" diff\n"
else
    printf "${GREEN}Everything is already in sync.${RESET}\n"
fi

echo
