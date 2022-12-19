" skip initialization for vim-tiny or vim-small.
if 0 | endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" luna colorscheme
Plug 'bcumming/vim-luna'
" sensible defaults
Plug 'tpope/vim-sensible'
" airline status bar
Plug 'bling/vim-airline'
" git in the gutter
Plug 'airblade/vim-gitgutter'
" use silver searcher in place of grep
Plug 'rking/ag.vim'
" control-p for finding files
Plug 'kien/ctrlp.vim'
" use .gitignore to filter for commands that search files
Plug 'vim-scripts/gitignore'
" unicode from latex
Plug 'joom/latex-unicoder.vim'
" provides fuzzy completer and clang based cleverness
" NOTE:
"   - You need to run an additional setup step to make this useable
"       cd ~/.vim/plugged/YouCompleteMe
"       python3 install.py
"
"   - For clang completion you have to type a few more characters
"
"       cd ~/.vim/plugged/YouCompleteMe
"       python3 install.py --clangd-completer  # option 1
"       python3 install.py --clang-completer   # option 2
"
"   - option 1: uses clangd server (recommended)
"   - option 2: uses old clang completer
"   - If getting strange errors related to YouCompleteMe, delete the
"     ~/.vim/plugged path and reinstall everything
"
"Plug 'ycm-core/YouCompleteMe'


" Initialize plugin system
call plug#end()

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

if !has('nvim')
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
endif

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

" fix background redraw for GPU accelerated terminals like Kitty
let &t_ut=''

"------------------------------------------
" plugin-specific settings
"------------------------------------------

"
" --- YouCompleteMe ---
"

" don't seek confirmation every time ycm_conf file is found
let g:ycm_confirm_extra_conf = 0

" go to definition of variable/type/function under cursor
nnoremap <leader>d  ::YcmCompleter GoTo<CR>
" print type of symbol under the cursor
nnoremap <leader>t  ::YcmCompleter GetType<CR>
" print type of symbol under the cursor
nnoremap <leader>f  ::YcmCompleter FixIt<CR>
" refactor the name under the cursor
nnoremap <leader>r  ::YcmCompleter RefactorRename<space>

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

"
" --- LaTeX to unicode ---
"
let g:unicoder_cancel_normal = 1
let g:unicoder_cancel_insert = 1
let g:unicoder_cancel_visual = 1
nnoremap <leader>u :call unicoder#start(0)<CR>
vnoremap <leader>u :<C-u>call unicoder#selection()<CR>

highlight YcmWarningSign    ctermfg=14
highlight YcmWarningSection ctermfg=14
highlight YcmErrorSign      ctermfg=14
highlight YcmErrorSection   ctermfg=14

highlight YcmWarningSection cterm=bold
highlight YcmErrorSection   cterm=bold

"
" --- ctrlp ---
"

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
