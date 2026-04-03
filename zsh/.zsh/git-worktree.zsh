wt() {
  local target="$1"
  local dir="$PWD"
  while [ "$dir" != "/" ]; do
    if [ -d "$dir/.worktrees" ]; then
      break
    fi
    dir=$(dirname "$dir")
  done

  if [ -z "$target" ]; then
    cd "$dir" || return 1
    pwd
    return 0
  fi

  if [ "$dir" = "/" ]; then
    echo "Could not find .worktrees directory in parent hierarchy." >&2
    return 1
  fi

  local worktree_dir="$dir/.worktrees/$target"

  if [ -d "$worktree_dir" ]; then
    cd "$worktree_dir" || return 1
    pwd
  else
    # Check if the branch exists
    if git show-ref --verify --quiet "refs/heads/$target"; then
      echo "Creating worktree for branch '$target'..." >&2
      git worktree add "$worktree_dir" "$target" || return 1
      cd "$worktree_dir" || return 1
      pwd
    else
      echo "Branch '$target' does not exist" >&2
      return 1
    fi
  fi
}

_wt() {
  local -a worktrees branches all_options
  local prefix=".worktrees/"

  worktrees=(${(f)"$(
    git worktree list --porcelain 2>/dev/null |
    awk '/^worktree / {print $2}' |
    sed -n "s|.*/$prefix||p"
  )"})

  branches=(${(f)"$(git for-each-ref --format='%(refname:short)' refs/heads/ 2>/dev/null)"})

  all_options=($worktrees $branches)
  all_options=(${(u)all_options})

  _describe 'branch/worktree' all_options
}

compdef _wt wt
