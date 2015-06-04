
" turn off vi-compatible mode
set nocompatible

set background=dark

" syntax hilighting
syntax on

 " swap between buffers without needing to save
set hidden

" none of these are word dividers
set iskeyword+=_,#

 " line numbers
set nu

" optimize macro execution by not redrawing until macro is finished
set lazyredraw

"set list " hilight tabs and trailing
"set listchars=tab:>-,trail:-

" show matching brackets
set showmatch

" leave 5 rows of space when scrolling
set scrolloff=5

" text formatting
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4 " make real tabs 4 wide

set wrap
set cindent

" make left and right keys cycle between tabs
nnoremap <Right> :tabnext<CR>
nnoremap <Left>  :tabprev<CR>

"colorscheme luna
"set t_Co=256

let mapleader = "\<Space>"

