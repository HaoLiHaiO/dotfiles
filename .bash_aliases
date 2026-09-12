################################################################################
# Git
################################################################################

alias ga='git add'
alias gaa='git add -A'
alias gba='git branch --all'
alias gbd='git branch -d'
alias gbD='git branch -D'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcann='git commit --amend --no-edit --no-verify'

alias gcl='git clone'
alias gco='git checkout'
alias gsw='git switch'
alias gswc='git switch -c'

alias gd='git diff'
alias gdc='git diff --cached'

alias gf='git fetch'
alias gfa='git fetch --all --prune'

alias gl='git log --branches --remotes --tags --graph --oneline --decorate'
alias gs='git status --short --branch'

alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpsuo='git push --set-upstream origin'

alias gpu='git pull'
alias gpuff='git pull --ff-only'
alias gpur='git pull --rebase --autostash'

alias gr='git rebase --autostash'
alias gri='git rebase --interactive'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias grs='git rebase --skip'

alias greh='git reset --hard'

alias gst='git stash'
alias gstl='git stash list'
alias gsts='git stash show'
alias gstp='git stash pop'
alias gstpi='git stash pop --index'
alias gsta='git stash apply'

alias gcp='git cherry-pick'
alias gcpc='git cherry-pick --continue'
alias gcpa='git cherry-pick --abort'

function gln() {
    local n="${1:-1}"
    git log "-$n"
}

# Detect origin's default branch instead of assuming main/master.
function gdefault() {
    local branch

    branch="$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)" || true

    if [[ -n "$branch" ]]; then
        printf '%s\n' "${branch#origin/}"
        return
    fi

    if git show-ref --verify --quiet refs/remotes/origin/main; then
        echo main
    elif git show-ref --verify --quiet refs/remotes/origin/master; then
        echo master
    else
        echo main
    fi
}

function gpurm() {
    local branch
    branch="$(gdefault)" || return
    git fetch --all --prune &&
        git pull --rebase --autostash origin "$branch"
}

function gpurmi() {
    local branch
    branch="$(gdefault)" || return
    git fetch --all --prune &&
        git rebase --interactive --autostash "origin/$branch"
}

function gmm() {
    local branch
    branch="$(gdefault)" || return
    git fetch --all --prune &&
        git merge "origin/$branch"
}

################################################################################
# Navigation / shell
################################################################################

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias dfh='df -h'
alias freem='free -h'
alias gh='history | grep'
alias left='ls -t -1'
alias sbr='source ~/.bashrc'

alias ports='ss -tulpn'
alias top='btop'

function cdr() {
    cd "$(git rev-parse --show-toplevel)" || return
}

function mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Manual fallback. XFCE itself handles Alt+Shift persistently.
alias changelang='setxkbmap -layout ch,us -option grp:alt_shift_toggle'

################################################################################
# Search
################################################################################

alias rgi='rg --hidden --glob "!.git/*"'
alias fdi='fd --hidden --exclude .git'

function ff() {
    fd --type f --hidden --exclude .git | fzf
}

################################################################################
# mise
################################################################################

alias mi='mise'
alias mil='mise list'
alias mia='mise current'
alias mii='mise install'
alias miu='mise upgrade'

################################################################################
# Codex
################################################################################

alias cx='codex'

function codexroot() {
    cdr && codex
}

################################################################################
# VS Code
################################################################################

alias co='code "$(git rev-parse --show-toplevel)"'
alias codehere='code .'

################################################################################
# Docker
################################################################################

alias d='docker'
alias dp='docker ps'
alias dpa='docker ps -a'
alias di='docker images'

alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'

alias dspa='docker system prune -a'
alias dsa='docker stop $(docker ps -q)'
alias dsta='docker start $(docker ps -qa)'

function dei() {
    docker exec -it "$@"
}

function dcuf() {
    local file="$1"
    shift
    docker compose -f "$file" up -d "$@"
}

function dcdf() {
    local file="$1"
    shift
    docker compose -f "$file" down "$@"
}

################################################################################
# tmux
################################################################################

alias t='tmux'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tl='tmux ls'
alias tk='tmux kill-session -t'

################################################################################
# Python
################################################################################

alias psh='pip show'

################################################################################
# Weather
################################################################################

alias dandongwetter='curl wttr.in/Dandong'
alias daqingwetter='curl wttr.in/Daqing'
alias hkwetter='curl wttr.in/Hongkong'
alias varnawetter='curl wttr.in/Varna'