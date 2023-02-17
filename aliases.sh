# Create a directory and move into it.
# `mkcd /path/to/directory`
_mkcd() {
  mkdir -p "$1"
  cd "$1"
}

# Move into a directory and list the contents.
# `cdl /path/to/directory`
_cdl() {
  cd "$1"
  ls
}

alias mkcd=_mkcd
alias cdl=_cdl

# this is "git checkout master" by default in oh-my-zsh
# but main/default are more common branch names now : )
alias gcm="git checkout main 2>/dev/null || git checkout default"

if which exa > /dev/null; then
  alias l="exa -l"
fi
