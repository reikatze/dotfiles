# zcompile function
function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

# fetch plugins
if [[ ! -e ${ZSHPLUGINS}/zsh-syntax-highlighting ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSHPLUGINS}/zsh-syntax-highlighting
fi
if [[ ! -e ${ZSHPLUGINS}/zsh-autosuggestions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ${ZSHPLUGINS}/zsh-autosuggestions
fi
if [[ ! -e ${ZSHPLUGINS}/zsh-history-substring-search ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search.git ${ZSHPLUGINS}/zsh-history-substring-search
fi
if [[ ! -e ${ZSHPLUGINS}/pure ]]; then
  git clone --depth=1 https://github.com/sindresorhus/pure.git ${ZSHPLUGINS}/pure
fi

# zcompile
zcompile-many ${ZSHPLUGINS}/**/*.zsh && zcompile-many ${ZSHPLUGINS}/**/**/*.zsh

# path
fpath+=(${ZSHPLUGINS}/pure)

# source plugins
source ${ZSHPLUGINS}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ${ZSHPLUGINS}/zsh-history-substring-search/zsh-history-substring-search.zsh
source ${ZSHPLUGINS}/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${HOME}/.nvm/nvm.sh

# completions
autoload -Uz compinit && compinit
[[ ${ZDOTDIR}/.zcompdump.zwc -nt ${ZDOTDIR}/.zcompdump ]] || zcompile-many ${ZDOTDIR}/.zcompdump

# prompt
autoload -Uz promptinit && promptinit && prompt pure

# aliases
alias ls="eza -lhg --icons --git"

# auto ls after cd
chpwd() {
  ls
}

# garbage collection
unfunction zcompile-many
