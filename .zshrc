PROMPT_EOL_MARK=''

ZSH_THEME=""

plugins=(git colored-man-pages command-not-found copyfile docker gradle node npm nvm pip battery zsh-syntax-highlighting)

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


source ~/.zshrcx

# may vary depending on os
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# for pure
fpath+=("$ZSH_CUSTOM/themes/pure")
autoload -U promptinit; promptinit
prompt pure
