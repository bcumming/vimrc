# vimrc

Organize my vim life.

The aim is to have a "nice" vim experience that is portable from desktop/laptop to servers.

```
cd ~
mv .vim .vim_back
mv .vimrc .vimrc_back
git clone --recursive https://github.com/bcumming/vimrc.git .vim
ln -s .vim/vimrc .vimrc
# neovim support
mkdir -p .config/nvim && ln -s ~/.vim/init.vim .config/nvim/init.vim
vim .vimrc
# dein will ask whether you want to install packages: say OK and go fix a cup of coffee
```
