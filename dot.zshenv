export EDITOR=vim

test -x ~/bin/git-ssh.sh && alias git='GIT_SSH=~/bin/git-ssh.sh git'
alias tmux='tmux -2'
alias pry='pry -I. -e "require '\''bundler'\'';Bundler.setup;"'

path=(
  ~/bin
  $path
)

test -r ~/.zshenv.local && source ~/.zshenv.local
