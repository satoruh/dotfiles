## zplug
source ~/.zplug/init.zsh

## autoloads
autoload -Uz promptinit ; promptinit
autoload -Uz colors ; colors
autoload -Uz compinit ; compinit
autoload -Uz is-at-least
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
autoload -Uz edit-command-line

## completion
zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for: %F{yellow}%d%f'
zstyle ':completion:*:descriptions' format '%F{yellow}completing %B%d%b%f'
zstyle ':completion:*:corrections' format '%F{yellow}%B%d%f %F{red}(errors: %e)%b%f'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''

## keybindings
bindkey -e

## plugins
zplug "zplug/zplug"

zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-history-substring-search"
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

## vcs
 ## http://d.hatena.ne.jp/mollifier/20100906/p1
 if is-at-least 4.3.7; then
     zstyle ':vcs_info:*' enable git svn hg bzr
     zstyle ':vcs_info:*' formats '(%s)-[%b]'
     zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
     zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
     zstyle ':vcs_info:bzr:*' use-simple true

     if is-at-least 4.3.10; then
         zstyle ':vcs_info:git:*' check-for-changes true
         zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
         zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'

         zstyle ':vcs_info:git+set-message:*' hooks \
           git_hook_begin \
           git_untracked

         function +vi-git_hook_begin() {
           test "$(command git rev-parse --is-inside-work-tree 2>/dev/null)" = 'true'
         }

         function +vi-git_untracked() {
           command git status --porcelain 2>/dev/null | grep -q -E -e '^\?\?' && hook_com[unstaged]+='?'
         }
     fi

     function _update_vcs_info_msg() {
         psvar=()
         LANG=en_US.UTF-8 vcs_info
         [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
     }

     add-zsh-hook precmd _update_vcs_info_msg
 fi

## options
setopt \
    auto_list \
    no_auto_menu \
    auto_param_keys \
    no_auto_remove_slash \
    auto_pushd \
    brace_ccl \
    check_jobs \
    no_clobber \
    complete_aliases \
    equals \
    extended_glob \
    extended_history \
    no_flow_control \
    hist_ignore_alldups \
    hist_ignore_dups \
    hist_ignore_space \
    hist_no_store \
    hist_reduce_blanks \
    hist_save_no_dups \
    hist_verify \
    ignore_eof \
    inc_append_history \
    list_packed \
    list_types \
    magic_equal_subst \
    mark_dirs \
    nomatch \
    notify \
    print_eight_bit \
    print_exit_value \
    prompt_cr \
    prompt_subst \
    pushd_ignore_dups \
    share_history \
    short_loops \
;

## variables
PROMPT="%F{red}%n%f@%F{yello}%m%f:%F{green}%~%f \
%F{yellow}%1(v.%1v.)%f \
%D %T
%# "

HISTFILE=~/.zhistory
HISTSIZE=99999
SAVEHIST=99999

# edit-command-live
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# functions
function peco-history-selection() {
  BUFFER=`history -r -n 1 | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^O^H' peco-history-selection

# direnv
eval "$(direnv hook zsh)"

# awscli
source /usr/local/share/zsh/site-functions/_aws

# rbenv
which rbenv >/dev/null 2>&1 && eval "$(rbenv init --no-rehash -)"

# Python
## pyenv
which pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"
## virtualenvwrapper
### ugly
### test -f /usr/local/bin/virtualenvwrapper.sh && source /usr/local/bin/virtualenvwrapper.sh

# golang
export GOPATH=${HOME}
export GOROOT=/usr/local/opt/go/libexec

path=(
  $GOPATH/bin
  $GOROOT/bin
  $path
)

# autoenv
#source /usr/local/opt/autoenv/activate.sh

## ssh-agent
test -r ${HOME}/.ssh-agent-info && source ${HOME}/.ssh-agent-info
ssh-add -l >&/dev/null
if [ $? = 2 ] ; then
	rm -rf ~/.ssh-agent-info
	ssh-agent >~/.ssh-agent-info
	source ~/.ssh-agent-info
fi

## gpg-agent
gpg-agent --daemon --quiet

# zsh local
test -r ${HOME}/.zshrc.local && source ${HOME}/.zshrc.local
