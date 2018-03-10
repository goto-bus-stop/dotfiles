# Create a directory and move into it.
# `mkcd /path/to/directory`
mkcd () {
  mkdir -p "$1"
  cd "$1"
}

cdl () {
  cd "$1"
  ls
}

alias mkcd=mkcd
alias cdl=cdl
