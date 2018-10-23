# Create a directory and move into it.
# `mkcd /path/to/directory`
mkcd() {
  mkdir -p "$1"
  cd "$1"
}

# Move into a directory and list the contents.
# `cdl /path/to/directory`
cdl() {
  cd "$1"
  ls
}

alias mkcd=mkcd
alias cdl=cdl

# this is "git checkout master" by default in oh-my-zsh
# but i like to use the `default` branch name
alias gcm="git checkout master 2>/dev/null || git checkout default"
