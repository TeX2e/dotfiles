
# inherited from .bashrc
source ~/.bashrc

# show todo
if which todo &> /dev/null; then
  todo
fi

###
# Set Shell variable
HISTSIZE=1000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=1000
PROMPT=$'%m%(2L.#%L.) %1~ %{$fg[cyan]%}%#%{$reset_color%} '

# Set Shell options
setopt always_last_prompt
unsetopt auto_name_dirs
unsetopt auto_param_keys
setopt auto_param_slash
unsetopt beep
unsetopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt ignore_eof
setopt interactive_comments
setopt list_types
setopt mark_dirs
setopt prompt_subst
setopt sh_word_split
setopt share_history
unsetopt nomatch # for rake arguments like: `rake subcomand[args]`
#setopt transient_rprompt # set the option for hiding RPROMPT to copy the string of the terminal

# Set Keybind
bindkey -e

# Alias and functions
alias .='source'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g M='| more'
alias -g L='| less'

# Using Completion
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B> Completing %d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _complete _prefix #_approximate
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z} r:|[-_.]=** m:to=2'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

zstyle ':completion:*:ruby:*' file-patterns '*.rb:ruby-script' '*(-/):dir'
zstyle ':completion:*:coffee:*' file-patterns '*.coffee:coffee-script' '*(-/):dir'
zstyle ':completion:*:python:*' file-patterns '*.py:python-script' '*(-/):dir'
zstyle ':completion:*:platex:*' file-patterns '*.tex:tex-file' '*(-/):dir'
zstyle ':completion:*:dvi*:*' file-patterns '*.dvi:dvi-file' '*(-/):dir'
zstyle ':completion:*:open:*' file-patterns '*.pdf:pdf-file' '*(-/):dir' '*:all-files'
zstyle ':completion:*:date:*' fake '+%Y-%m-%d'
zstyle ':completion:*:subl:*' file-patterns '*.*:files' '*:all-files'
zstyle ':completion:*:perl:*' file-patterns '*.pl:perl-script' '*.p6:perl6-script' '*:all-files'

autoload -Uz compinit && compinit
###


# Git status
#   green when working directory is clean
#   yellow when it has untracked files
#   red when changes are not staged for commit
#   bold red when it has untracked files and changes are not staged
#
# load ${fg[...]} and $reset_color
autoload -U colors; colors

function git-current-branch {
  local name st color

  [[ "$PWD" =~ '/\.git(/.*)?$' ]] && return

  # branch name
  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  [[ -z $name ]] && return

  # set color
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=${fg[green]}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=${fg[yellow]}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=${fg_bold[red]}
  else
    color=${fg[red]}
  fi

  echo "${origin_diff} %{$color%}$name%{$reset_color%}"
}

# whenever a prompt is shown, evaluate a string of $RPROMPT and replace it
setopt prompt_subst
RPROMPT='`git-current-branch`'
