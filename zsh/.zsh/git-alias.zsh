alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gap='git add --patch'
alias gb='git branch'
alias gbl='git branch --list'
alias gbc='git branch --show-current'
alias gbm='git branch --move'
alias gca='git commit --amend'
alias gcam="git commit --all -m"
alias gcan='git commit --amend --no-edit'
alias gc="git commit"
alias gcm="git commit -m"
alias gcl='git clean'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gdn='git diff --name-only'
alias gf='git fetch'
alias gl='git l'
alias glg='git lg'
alias gm='git merge'
alias gcp='git cherrypick'
alias grb='git rebase'
alias gph='git push'
alias gpl='git pull'
alias gr='git reset'
alias grs='git restore'
alias gsh='git stash'
alias gs='git status'

gsmr() {
  git submodule deinit -f $1
  git rm -f $1
  rm -rf .git/modules/$1
}

gis() {
  if [ "$1" ]; then
    gh issue view --web $1
  else
    gh issue view --web \`git branch --show-current | grep -o '\#[0-9]\+'\`
  fi
}

alias gpr="gh pr view --web >/dev/null 2>&1 || gh pr create --web --assignee @me"

alias gre="gh repo view --web"
