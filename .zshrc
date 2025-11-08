# autoload -Uz promptinit
# promptinit
# prompt adam1

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# History set-up
HISTFILE=~/.config/.history
SAVEHIST=5000
HISTSIZE=4999

setopt SHARE_HISTORY
setopt APPEND_HISTORY

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

unsetopt EXTENDED_HISTORY

#####################################################################################################


#####################################################################################################

# Use modern completion system
autoload -Uz compinit
compinit -i

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' path-completion no-recursive
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' globbing_directories ignore
#
# if [ "$color_prompt" = yes ]; then
#   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#   PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt
#
# if [ -n "$force_color_prompt" ]; then
#   if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#     # We have color support; assume it's compliant with Ecma-48
#     # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#     # a case would tend to support setf rather than setaf.)
#     color_prompt=yes
#   else
#     color_prompt=
#   fi
# fi



#####################################################################################################

#####################################################################################################

# Path's

[ -f ~/.config/.aliases ] && source ~/.config/.aliases

export PATH=/snap/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/opt/neovim/bin"
export PATH="$PATH:$HOME/.local/bin"

. "$HOME/.cargo/env"

export VIRTUAL_ENV_DISABLE_PROMPT=1

if [[ -n "$TMUX" ]]; then
  export TERM=tmux-256color
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^J' history-substring-search-down
bindkey '^K' history-substring-search-up
bindkey '^ ' autosuggest-accept
#####################################################################################################

#####################################################################################################

# Custom Prompt 

PROMPT_END_SYMBOL="❯"  # Unicode end symbol

# Function to get formatted working directory
prompt_dir() {
  local dir="${PWD/#$HOME/~}"  # Replace home with ~
  local parent="${dir%/*}"  # Get parent directories
  local current="${dir##*/}"  # Get current directory

  if [[ "$dir" == "~" ]]; then
    print -n "%B%F{#00afff}~/%f%b"
    return
  fi

  if [[ "$dir" == "/" ]]; then
    print -n "%B%F{#0087af}/%f%b"
    return
  fi

  # Format with colors
  [[ "$dir" == "~/" ]] && print -n "%B%F{#00afff}~%f%b" && return
  print -n "%B%F{#0087af}${parent}/%f%b"
  print -n "%B%F{#00afff}${current}%f%b"
}
venv_prompt() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    venv_name=$(basename "$VIRTUAL_ENV")  # Extract the name
    echo -n "%F{#5fd700}($venv_name)%f " # Green color, customize as needed
  fi
}
# %F{#5fd700}
#          
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' %{%F{226}%}(%{%F{10}%}%b%{%F{226}%})'
setopt PROMPT_SUBST

# Final prompt definition

PROMPT=$'\n$(prompt_dir)  ${vcs_info_msg_0_}  $(venv_prompt)\n''%f'$PROMPT_END_SYMBOL'%f '

# PROMPT=$'\n''$(prompt_dir)' ${vcs_info_msg_0_} $(venv_prompt)'$'\n'$PROMPT_END_SYMBOL'%f '

# disable cursor blinking
# printf "\e[?12l"
