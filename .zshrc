## autoloads
autoload -Uz promptinit ; promptinit
autoload -Uz colors ; colors
autoload -Uz compinit ; compinit
autoload -Uz is-at-least
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

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

## ssh-agent
test -r ${HOME}/.ssh-agent-info && source ${HOME}/.ssh-agent-info
ssh-add -l >&/dev/null
if [ $? = 2 ] ; then
	rm -rf ~/.ssh-agent-info
	ssh-agent >~/.ssh-agent-info
	source ~/.ssh-agent-info
fi

## gpg-agent
gpg_agent_info=~/.gpg-agent-info
if test -f ${gpg_agent_info}; then
  source ${gpg_agent_info}
  gpg_agent_pid=$(echo ${GPG_AGENT_INFO} | sed -e 's/.*gpg-agent:\([^:]*\):.*$/\1/')
  if test "$(pgrep gpg-agent)" -eq "${gpg_agent_pid}" > /dev/null; then
    export GPG_AGENT_INFO
  else
    rm -f ${gpg_agent_info}
  fi
fi
if ! test -f ${gpg_agent_info}; then
  eval $(gpg-agent --daemon --write-env-file ${gpg_agent_info})
fi

# awscli
source /usr/local/share/zsh/site-functions/_aws

# functions
function peco-history-selection() {
  BUFFER=`history -r -n 1 | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N peco-history-selection
bindkey '^O^H' peco-history-selection

## node.js
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# rbenv
which rbenv >/dev/null 2>&1 && eval "$(rbenv init --no-rehash -)"

# pyenv
which pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"

# golang
export GOPATH=${HOME}
export GOROOT=/usr/local/opt/go/libexec

path=(
  $GOPATH/bin
  $GOROOT/bin
  $path
)

test -r ${HOME}/.zshrc.local && source ${HOME}/.zshrc.local

# attach tmux
function is_tmux_running() { test ! -z "$TMUX" }
if ! is_tmux_running; then
  if tmux list-sessions >/dev/null 2>&1; then
    tmux attach-session
  else
    tmux
  fi
fi