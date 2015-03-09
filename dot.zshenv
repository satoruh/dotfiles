export PATH="/opt/eshop_tools/bin:${HOME}/.corkscrew/corkscrew-2.0:${HOME}/.packer:${HOME}/.jq:${HOME}/.dlang/bin:${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${HOME}/perl5/bin:${HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export EDITOR=vim

alias bi='bundle install -j4'
alias be='bundle exec'
alias bu='bundle update -j4'
alias git='GIT_SSH=~/bin/git-ssh.sh git'
alias tmux='tmux -2'
alias pry='pry -I. -e "require '\''bundler'\'';Bundler.setup;"'

path=(
  ~/bin
  $path
)

test -d /usr/local/var/pyenv && export PYENV_ROOT=/usr/local/var/pyenv
test -x pyenv && eval "$(pyenv init -)"
test -d /usr/local/var/rbenv && export RBENV_ROOT=/usr/local/var/rbenv
if test -x rbenv && eval "$(rbenv init --no-rehash -)"
