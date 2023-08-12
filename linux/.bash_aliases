alias py='python3'
alias get="sudo apt install"
alias remove='sudo apt remove'
alias c="clear"
alias ..="cd ../"
alias ....="cd ../.."

# Essential
alias a='code .'
alias reveal-md="reveal-md --theme night --highlight-theme hybrid --port 1337"
alias ns='npm start'
alias start='npm start'
alias nr='npm run'
alias run='npm run'
alias nis='npm i -S'
alias l="ls" # List files in current directory
alias ll="ls -al" # List all files in current directory in long list format
alias o="open ." # Open the current directory in Finder

# ----------------------
# Git Aliases
# ----------------------
alias gf="git clone"
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gi='git init'
alias gl='git log'
alias gp='git pull'
alias gpsh='git push'
alias gss='git status -s'


#Creating new Folder and Get into it.

create ()
{
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}
