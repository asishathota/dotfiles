bindkey -e

HISTFILE=~/.config/.history
SAVEHIST=5000
HISTSIZE=4999

setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

autoload -Uz compinit
compinit -i -d ~/.cache/zsh/.zcompdump

#==========aliases===========#
[ -f ~/.config/.aliases ] && source ~/.config/.aliases


#=======zsh plugin configuration=======#
[ -f ~/plugins/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source ~/plugins/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/plugins/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ] && source ~/plugins/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
[ -f ~/plugins/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/plugins/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '^J' history-substring-search-down
bindkey '^K' history-substring-search-up
bindkey '^ ' autosuggest-accept


#================prompt================#
[ -f ~/.config/zsh/.zshprompt ] && source ~/.config/zsh/.zshprompt




