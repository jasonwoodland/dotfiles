ts() {
  tmux -2 attach -t $1 2> /dev/null || tmux -2 new -s $1
}

# don't froget to rm ~/.zcompdump when you're finished

alias tl="tmux ls"
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
# alias ts='tmux new-session -s'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# compdef _ts ts
