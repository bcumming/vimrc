# vimrc

Organize my vim life.

The aim is to have a "nice" vim experience that is portable from desktop/laptop to servers.

```
cd ~
mv .vim .vim_back
mv .vimrc .vimrc_back
git clone https://github.com/finkandreas/vimrc.git .vim
ln -s .vim/vimrc .vimrc
# neovim support
mkdir -p .config/nvim && ln -s ~/.vim/init.vim .config/nvim/init.vim
# to install all plugins
vim +PlugInstal +qall # skip +qall if you want to see the results
cd ~/.vim/plugged/YouCompleteMe
./install.py --clangd-completer --rust-completer --go-completer
```

For neovim you need the neovim python module installed, otherwise YouCompleteMe does not work.
Either install it with your package manager or create a virtual environment
```
python3 -m venv $HOME/python_venv
$HOME/python_venv/bin/activate
pip install neovim
```
Also make sure, that you add `$HOME/python_venv/bin/activate` to your .bashrc (or equivalent)
