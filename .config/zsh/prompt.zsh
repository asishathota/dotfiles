PROMPT_END_SYMBOL="❯"

export VIRTUAL_ENV_DISABLE_PROMPT=1

prompt_dir() {
  local dir="${PWD/#$HOME/~}"
  local parent="${dir%/*}"
  local current="${dir##*/}"

  if [[ "$dir" == "~" ]]; then
    print -n "%B%F{#00afff}~/%f%b"
    return
  fi

  if [[ "$dir" == "/" ]]; then
    print -n "%B%F{#0087af}/%f%b"
    return
  fi

  [[ "$dir" == "~/" ]] && print -n "%B%F{#00afff}~%f%b" && return
  print -n "%B%F{#0087af}${parent}/%f%b"
  print -n "%B%F{#00afff}${current}%f%b"
}

venv_prompt() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    venv_name=$(basename "$VIRTUAL_ENV")
    echo -n "%F{#5fd700}($venv_name)%f "
  fi
}

#          
autoload -Uz vcs_info

precmd() { vcs_info }
zstyle ':vcs_info:*' enable git

zstyle ':vcs_info:git:*' formats ' %{%F{226}%}(%{%F{10}%}%b%{%F{226}%})'

setopt PROMPT_SUBST

PROMPT=$'\n$(prompt_dir)  ${vcs_info_msg_0_}  $(venv_prompt)\n''%f'$PROMPT_END_SYMBOL'%f '
