PROMPT_EOL_MARK=''

ZSH_THEME="avit"

plugins=(git colored-man-pages command-not-found copyfile docker gradle node npm nvm pip virtualenv battery zsh-syntax-highlighting)

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


source ~/.zshrcx
