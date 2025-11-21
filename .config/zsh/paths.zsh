# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/bin:$PATH"

# snap binaries
export PATH=/snap/bin:$PATH

# neovim application path
export PATH="$PATH:/opt/neovim/bin"

# yazi path
export PATH="/opt/yazi:$PATH"

# rust binaries
. "$HOME/.cargo/env"

# java binaries
export PATH="/usr/lib/jvm/java-21-openjdk-amd64/bin:$PATH"

# node binaries
export PATH="$HOME/.nvm/versions/node/v24.11.0/bin:$PATH"

