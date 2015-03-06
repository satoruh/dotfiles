autoload -Uz is-at-least
autoload -Uz add-ash-hook
autoload -Uz colors; colors
autoload -Uz promptinit; promptinit

# options
bindkey -e
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

# prompt
PROMPT="%F{red}%n%f@%F{yellow}%m%f:%F{green}%~%f \
%F{yellow}%1(v.%1v.)%f \
%D %T
%N %L %# "

# history
HISTFILE=~/.zsh_history
HISTSIZE=99999
SAVEHIST=99999

# completion
autoload -Uz compinit; compinit
zstyle :compinstall filename '~/.zshrc'
zstyle ':completion:*' list-colors
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for: %F{yellow}%d%f'
zstyle ':completion:*:description' format '%F{yellow}completing %B%d%b%f'
zstyle ':completion:*:corrections' format '%F{yellow}%B%d%f %F{red}(errors: %e)%b%f'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:' group-name ''

# vcs
autoload -Uz vcs_info
if is-at-least 4.3.7; then
  zstyle ':vcs_info:*' enable git svn hg bzr
  zstyle ':vcs_info:*' format '(%s)-[%b]'
  zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
  zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
  zstyle ':vcs_info:bzr:*' use-simple true

  if is-at-least 4.3.10; then
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
  fi

  fuction _update_vcs_info_msg() {
    psvar=()
    LANG=C vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
  }

  add-zsh-hook precmd _update_vcs_info_msg
fi

#
test -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 

alias pry='pry -I. -e "require '\''bundler'\'';Bundler.setup;"'
alias bi='bundle install --path vendor/bundle'
alias be='bundle exec'
