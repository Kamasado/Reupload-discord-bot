# custom commands
alias u='sudo apt-fast update'

function i {
  sudo apt-fast install -y $@
}

function cl {
  git clone $@
}

alias ga='git add -A'

function gc {
  git commit -m "$@"
}

alias gp='git push'

alias gpf='git push -u origin master'

alias gpass='git config credential.helper store'
