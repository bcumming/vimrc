" skip initialization for vim-tiny or vim-small.
if 0 | endif

"------------------------------------------
" neobundle
"------------------------------------------
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

" --- my bundles ---

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
" support for syntax, indentation etc in Julia
NeoBundle 'JuliaLang/julia-vim'
" easy swapping of windows
NeoBundle 'wesQ3/vim-windowswap.git'
" unicode from latex
NeoBundle 'joom/latex-unicoder.vim'

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

" turn on file specific rules set in the path ~/.vim/after/__language__.vim
" also required by neobundle
filetype plugin indent on

" prompt to install uninstalled bundles found on startup
NeoBundleCheck

"------------------------------------------
" general settings
"------------------------------------------

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

" leave 10 rows of space when scrolling
set scrolloff=10

" text formatting
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4 " make real tabs 4 wide

" wrap long lines
set wrap

" Tell vim to remember certain things when we exit
" '10  :  marks will be remembered for up to 10 previously edited files
" "100 :  will save up to 100 lines for each register
" :20  :  up to 20 lines of command-line history will be remembered
set viminfo='10,\"100,:20,%,n~/.viminfo

" now restore position based on info saved in viminfo
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

"------------------------------------------
" search options
"------------------------------------------
" search as characters are entered
set incsearch
" highlight matches
set hlsearch

"------------------------------------------
" color scheme settings
"------------------------------------------
set background=dark
if has("gui_running")
    colorscheme luna
else
    colorscheme luna-term
    set t_Co=256
endif

" hilight current line by making the row number on the lhs stand out
set cursorline
hi CursorLine ctermbg=NONE cterm=NONE term=NONE
hi CursorLineNr ctermfg=166 ctermbg=236  term=bold cterm=bold

"------------------------------------------
" key bindings
"------------------------------------------

" in interactive mode hitting ;; quickly produces an underscore
inoremap ;; _

" automatic closing of braces and quotes
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" set leader to space
let mapleader = "\<Space>"

" hit leader then "e" to reload files that have changed outside the editor
nnoremap <leader>e :edit<CR>

" hit leader then "n" to remove line numbers
nnoremap <leader>n :set nu!<CR>

" hit space space to remove hilights from previous search
nnoremap <leader><Space> :nohlsearch<CR>

" toggle paste mode
" this ignores indentation rules when pasting
nnoremap <leader>p :set paste! paste?<CR>

" make left and right keys cycle between tabs
nnoremap <right> :tabnext<CR>
nnoremap <left>  :tabprev<CR>
" make up and down keys move tabs left and right
nnoremap <up>    :tabm -1<CR>
nnoremap <down>  :tabm +1<CR>
" use leader with up-down and left-right to switch window focus
nnoremap <leader>l <C-w>l
nnoremap <leader>h <C-w>h
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j

" go to definition of variable/type/function under cursor
nnoremap <leader>d  ::YcmCompleter GoTo<CR>
" print type of symbol under the cursor
nnoremap <leader>t  ::YcmCompleter GetType<CR>

" latex to unicode
let g:unicoder_cancel_normal = 1
let g:unicoder_cancel_insert = 1
let g:unicoder_cancel_visual = 1
nnoremap <leader>u :call unicoder#start(0)<CR>
vnoremap <leader>u :<C-u>call unicoder#selection()<CR>

"------------------------------------------
" plugin-specific settings
"------------------------------------------

" --- ctrlp ---
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
