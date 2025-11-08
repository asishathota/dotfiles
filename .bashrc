case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=no
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -f ~/.config/bash/.aliases ]; then
    . ~/.config/bash/.aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###########################################################################################

########################################
# Custom Bash Prompt (final fixed version)
########################################

PROMPT_END_SYMBOL="❯"
GIT_BRANCH_SYMBOL=""  # or " "  if not rendering

# Function to get formatted working directory
prompt_dir() {
  # Convert /home/<username> to ~ manually (works even in WSL)
  local dir="$PWD"
  local home_prefix="$HOME"

  # Force remove trailing slash from $HOME for comparison
  home_prefix="${home_prefix%/}"

  if [[ "$dir" == "$home_prefix" || "$dir" == "$home_prefix/"* ]]; then
    dir="~${dir#$home_prefix}"
  fi

  local parent="${dir%/*}"
  local current="${dir##*/}"

  # Root directory
  if [[ "$dir" == "/" ]]; then
    printf "%b" "\[\e[38;2;0;175;240m\]/\[\e[0m\]"
    return
  fi

  # Home only (~)
  if [[ "$dir" == "~" ]]; then
    printf "%b" "\[\e[38;2;0;175;240m\]~\[\e[0m\]"
    return
  fi

  # Print with colors
  printf "%b" "\[\e[38;2;0;143;195m\]${parent}/\[\e[38;2;0;175;240m\]${current}\[\e[0m\]"
}

# Function for virtual environment
venv_prompt() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local venv_name
    venv_name=$(basename "$VIRTUAL_ENV")
    printf "%b" "\[\e[38;2;102;255;102m\](${venv_name})\[\e[0m\] "
  fi
}

# Function to get Git branch
git_branch() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    printf "%b" " \[\e[38;2;255;255;255m\]$GIT_BRANCH_SYMBOL \[\e[38;2;255;230;64m\](\[\e[38;2;102;255;102m\]${branch}\[\e[38;2;255;230;64m\])\[\e[0m\]" 
  fi
}

# Function to dynamically color ❯
set_prompt() {
  local prompt_color
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    prompt_color="\[\e[38;2;255;230;64m\]"   # Yellow in git repo
  else
    prompt_color="\[\e[38;2;255;255;255m\]" # White otherwise
  fi

  PS1="
$(venv_prompt)$(prompt_dir)$(git_branch)\n${prompt_color}${PROMPT_END_SYMBOL}\[\e[0m\] "
}

PROMPT_COMMAND=set_prompt

. "$HOME/.cargo/env"
