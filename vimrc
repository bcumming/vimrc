" skip initialization for vim-tiny or vim-small.
if 0 | endif

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/bundle/')
  call dein#begin('~/.vim/bundle/')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/bundle/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('bcumming/vim-luna')
  " sensible defaults
  call dein#add('tpope/vim-sensible')
" airline status bar
  call dein#add('bling/vim-airline')
" awesome git!
  call dein#add('tpope/vim-fugitive')
" git in the gutter
  call dein#add('airblade/vim-gitgutter')
" use silver searcher in place of grep
  call dein#add('rking/ag.vim')
" control-p for finding files
  call dein#add('kien/ctrlp.vim')
" use .gitignore to filter for commands that search files
  call dein#add('vim-scripts/gitignore')
" support for syntax, indentation etc in Julia
  call dein#add('JuliaLang/julia-vim')
" easy swapping of windows
  call dein#add('wesQ3/vim-windowswap.git')
" unicode from latex
  call dein#add('joom/latex-unicoder.vim')
  call dein#add('thirtythreeforty/lessspace.vim')
  call dein#add('kana/vim-altr.git')
  " auto-insertion of brackets-like characters with jump markers (hit <C-J> to
  " jump to the next marker
  call dein#add('LucHermitte/lh-vim-lib')
  call dein#add('LucHermitte/lh-style')
  call dein#add('LucHermitte/lh-brackets')
  if v:version > 703
    " provides fuzzy completer and clang based cleverness
    call dein#add('Valloric/YouCompleteMe', {'build': 'python3 install.py --clang-completer'})
  endif

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
" turn on file specific rules set in the path ~/.vim/after/__language__.vim
" also required by neobundle
filetype plugin indent on

" syntax hilighting
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

"------------------------------------------
" general settings
"------------------------------------------

" Altr settings to switch between buffers
call altr#define('%/src/%.cpp', '%/include/%.h')

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
set listchars=tab:-.,trail:█

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
if !has('nvim')
  set viminfo='10,\"100,:20,%,n~/.viminfo
endif

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

nmap <F2> <Plug>(altr-forward)
nmap <F3> <Plug>(altr-back)

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
" use leader with "lhkj" movements to switch window focus
nnoremap <leader>l <C-w>l
nnoremap <leader>h <C-w>h
nnoremap <leader>k <C-w>k
nnoremap <leader>j <C-w>j
" use leader with up-down-left-right to resize the current window
nnoremap <leader><right> :vertical resize +5<CR>
nnoremap <leader><left>  :vertical resize -5<CR>
nnoremap <leader><up>    :resize +5<CR>
nnoremap <leader><down>  :resize -5<CR>

" default compilation flags for Ycm
let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_extra_conf.py"
" go to definition of variable/type/function under cursor
nnoremap <leader>d  ::YcmCompleter GoTo<CR>
" print type of symbol under the cursor
nnoremap <leader>t  ::YcmCompleter GetType<CR>
" Go to include file on current line
nnoremap <leader>o  ::YcmCompleter GoToInclude<CR>

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

" --- lh-bracket ---
" delete empty placeholders when we jump to them
let g:marker_select_empty_marks = 0
