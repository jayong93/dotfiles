chsh -s `which zsh`
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install pure prompt
OMZ_FPATH="${HOME}/.oh-my-zsh/functions"
mkdir -p "${OMZ_FPATH}"
curl -o "${OMZ_FPATH}/prompt_pure_setup" -fsSL "https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh"
curl -o "${OMZ_FPATH}/async" -fsSL "https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh"
if [ -f "${HOME}/.zshrc" ]; then
    sed -i "s/ZSH_THEME=\".*\"/ZSH_THEME=\"refined\"/g" "${HOME}/.zshrc"
fi
