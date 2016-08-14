export EDITOR=vim

test -x ~/bin/git-ssh.sh && alias git='GIT_SSH=~/bin/git-ssh.sh git'
alias tmux='tmux -2'
alias pry='pry -I. -e "require '\''bundler'\'';Bundler.setup;"'
alias peco='reattach-to-user-namespace peco'
alias open='reattach-to-user-namespace open'
alias terminal-notifier='reattach-to-user-namespace terminal-notifier'

path=(
  ~/bin
  /usrlocal/bin/
  $path
)

source $(brew --prefix)/etc/brew-wrap

test -r ~/.zshenv.local && source ~/.zshenv.local
