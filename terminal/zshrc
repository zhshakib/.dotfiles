# Created by newuser for 5.9

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
# ============================================================
# Personal Zsh Configuration
# ============================================================

# -------------------------
# Zsh behavior
# -------------------------

# Type a directory name to cd into it
setopt autocd

# Allow comments in interactive commands
setopt interactivecomments

# ============================================================
# Directory Navigation
# ============================================================


# -------------------------
# History
# -------------------------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# Append history instead of overwriting it
setopt appendhistory

# Don't save duplicate commands
setopt hist_ignore_dups

# Don't save commands beginning with a space
setopt hist_ignore_space

# Share history between open terminals
setopt share_history


# ============================================================
# Completion
# ============================================================

autoload -Uz compinit
compinit

# Better completion behavior
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ''


# ============================================================
# Plugins
# ============================================================
# ============================================================
# Fuzzy Finder (fzf)
# ============================================================

# Enable fzf's Zsh integration
source <(fzf --zsh)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080'
# Command history suggestions
zinit light zsh-users/zsh-autosuggestions
# Syntax highlighting MUST be loaded last
zinit light zsh-users/zsh-syntax-highlighting
# ============================================================
# Zoxide
# ============================================================

eval "$(zoxide init zsh --cmd z)"

zoi() {
    local dir
    dir="$(zoxide query -i)" && cd -- "$dir"
}
# ============================================================
# Prompt
# ============================================================
eval "$(starship init zsh)"
