# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ashu/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/ashu/.fzf/bin"
fi

source <(fzf --zsh)
