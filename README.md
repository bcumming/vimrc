# vimrc

Organize my vim life.

The aim is to have a "nice" vim experience that is portable from desktop/laptop to servers.

To set up

```bash
cd ~
# back up your old vim setup in case things go pear-shaped
mv .vim .vim_back
mv .vimrc .vimrc_back
# clone the vim configuration
git clone https://github.com/bcumming/vimrc.git .vim
# set up a simlink to for vimrc
ln -s .vim/vimrc .vimrc
```

Then open vim and run `:PlugInstall` to install all of the plugins.

To set up YouCompleteMe requires an additional configuration step:

```bash
cd .vim/plugged/YouCompleteMe/
python3 install.py --clangd-completer
```

This uses clangd, which does not require `.ycm_extra_conf.py` in your project.
Instead, run CMake and copy the `compile_commands.json` into the root of the project.
This has the benefit of using the flags specific to that build.
