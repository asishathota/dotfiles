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

#==========eza config===========#
export EZA_COLORS="di=38;5;75:ln=38;5;117:so=38;5;75:pi=38;5;168:ex=38;5;81:bd=38;5;75:cd=38;5;75:su=38;5;203:sg=38;5;167:tw=38;5;108:ow=38;5;108:st=38;5;75:ca=38;5;75:mi=38;5;237:or=38;5;203:rs=38;5;145:mh=38;5;145:ma=38;5;203:ta=38;5;145:*.c=38;5;81:*.h=38;5;117"

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

