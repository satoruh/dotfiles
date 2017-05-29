export EDITOR=vim

test -x ~/bin/git-ssh.sh && alias git='GIT_SSH=~/bin/git-ssh.sh git'
alias tmux='tmux -2'
alias peco='reattach-to-user-namespace peco'
alias open='reattach-to-user-namespace open'
alias pbcopy='reattach-to-user-namespace pbcopy'
alias terminal-notifier='reattach-to-user-namespace terminal-notifier'

path=(
  ~/bin(N-/)
  /usr/local/bin(N-/)
  /usr/local/opt/coreutils/libexec/gnubin(N-/
  $path
)

fpath=(
  ~/.zsh/functions
  $fpath
)

source $(brew --prefix)/etc/brew-wrap

test -r ~/.zshenv.local && source ~/.zshenv.local
