path=(
    ~/bin
    $path
)

export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init --no-rehash -)"; fi

export EDITOR=vim
