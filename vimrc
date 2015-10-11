" skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
    " turn off vi compatability
    if &compatible
        set nocompatible
    endif

    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" ----------------
" my bundles
" ----------------
" luna colorscheme
NeoBundle 'bcumming/vim-luna'
" sensible defaults
NeoBundle 'tpope/vim-sensible'
" airline status bar
NeoBundle 'bling/vim-airline'
" awesome git!
NeoBundle 'tpope/vim-fugitive'
" git in the gutter
NeoBundle 'airblade/vim-gitgutter'
" use silver searcher in place of grep
NeoBundle 'rking/ag.vim'
" control-p for finding files
NeoBundle 'kien/ctrlp.vim'
" use .gitignore to filter for commands that search files
NeoBundle 'vim-scripts/gitignore'

if v:version > 703
    " provides fuzzy completer and clang based cleverness
    NeoBundle 'Valloric/YouCompleteMe', {
         \ 'build'      : {
            \ 'mac'     : './install.sh --clang-completer',
            \ 'unix'    : './install.sh --clang-completer',
            \ }
         \ }
endif

call neobundle#end()

" required by neobundle
filetype plugin indent on

" prompt to install uninstalled bundles found on startup
NeoBundleCheck

" set leader to space
let mapleader = "\<Space>"

" syntax hilighting
syntax on

" utf
set encoding=utf-8

 " swap between buffers without needing to save
set hidden

" none of these are word dividers
set iskeyword+=_,#

 " line numbers
set nu

" optimize macro execution by not redrawing until macro is finished
set lazyredraw

" hilight tabs and trailing spaces
set list
set listchars=tab:-.,trail:.

" show matching brackets
set showmatch

" leave 5 rows of space when scrolling
set scrolloff=5

" text formatting
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4 " make real tabs 4 wide

" hilight current line
set cursorline

set wrap
set cindent

" search options
" search as characters are entered
set incsearch
" highlight matches
set hlsearch
" hit leader then "n" to remove hilights from previous search
nnoremap <leader>n :nohlsearch<CR>

" make left and right keys cycle between tabs
nnoremap <Right> :tabnext<CR>
nnoremap <Left>  :tabprev<CR>

" color scheme settings
set background=dark
if has("gui_running")
    colorscheme luna
else
    colorscheme luna-term
    set t_Co=256
endif

" use the combination jk to exit insert mode
" ... easier than reaching up for the escape key
inoremap jk <ESC>
nnoremap <Leader>q :wqa<CR>

" configure ctrlp to use ag for searching
" this interacts nicely with the gitignore vim package
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
