" skip initialization for vim-tiny or vim-small.
if 0 | endif

" Enable this with care. Colors are applied from the GUI subset, not term subset
" Take good care of the colorscheme that is applied, because it only checks for
" if a gui is running, not if termguicolors is enabled, this should probably be
" changed accordingly
"if exists('+termguicolors')
"  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"  set termguicolors
"endif


" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
    " luna colorscheme
    Plug 'bcumming/vim-luna'
    " sensible defaults
    Plug 'tpope/vim-sensible'
    " airline status bar
    Plug 'bling/vim-airline'
    " git in the gutter
    Plug 'airblade/vim-gitgutter'
    " use silver searcher in place of grep
    Plug 'mileszs/ack.vim'
    " control-p for finding files
    Plug 'kien/ctrlp.vim'
    " use .gitignore to filter for commands that search files
    Plug 'vim-scripts/gitignore'
    " strip whitespace after exiting Insert mode
    Plug 'thirtythreeforty/lessspace.vim'
    " keep track of surroundings (brackets, parantheses, xml tags, etc)
    Plug 'tpope/vim-surround'
    " repeat commands from plugins (i.e. when you press .)
    Plug 'tpope/vim-repeat'
    " ale linter
    Plug 'dense-analysis/ale'

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
    Plug 'ycm-core/YouCompleteMe'
call plug#end()

"------------------------------------------
" general settings
"------------------------------------------

" syntax hilighting
syntax on

" tab completion to complete only common parts
set wildmode=longest,list,full
set wildmenu

" utf
set encoding=utf-8

" swap between buffers without needing to save
set hidden
set history=5000
set undolevels=1000

" none of these are word dividers
set iskeyword+=_,#

" line numbers
set nu rnu

" optimize macro execution by not redrawing until macro is finished
set lazyredraw

" show matching brackets
set showmatch

" leave 10 rows of space when scrolling
set scrolloff=10

" text formatting
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4 " make real tabs 4 wide

" open new vsplits on the right
set splitright
" open new hsplits below
set splitbelow

" wrap long lines
set wrap

" Do not fold when a file is opened
set nofoldenable

" use system clipboard for copying
set clipboard=unnamedplus

" Limit popup menu height
set pumheight=20

" reduce updatetime for faster YCM help popups
set updatetime=1000

" autoread files, i.e. reload on change (on terminal focus a check is run)
set autoread
au FocusGained * :checktime

" per project settings (.nvimrm / .vimrc)
"set exrc
"set secure

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
" ignore case when searching
set ignorecase
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

" hilight tabs
set list
set listchars=tab:>-

" highlight trailing whitespaces
:highlight ExtraWhitespace ctermbg=red guibg=red
" " Show trailing whitespace and spaces before a tab:
:match ExtraWhitespace /\s\+$\| \+\ze\t/
" " Switch off :match highlighting.
" :match
"

" hilight current line by making the row number on the lhs stand out
set cursorline
hi CursorLine ctermbg=236 cterm=bold term=bold
hi CursorLineNr ctermfg=green ctermbg=236  term=bold cterm=bold

" disable background, use term background
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE

" parantheses matches
hi MatchParen ctermbg=red cterm=bold ctermfg=white


"------------------------------------------
" key bindings
"------------------------------------------

" in interactive mode hitting ;; quickly produces an underscore
inoremap ;; _

" set leader to space
let mapleader = "\<Space>"

" hit leader then "e" to reload files that have changed outside the editor
nnoremap <leader>e :edit<CR>

" hit leader then "n" to toggle between absolute/relative/no line numbers
" noremap <silent> <Leader>n :if &number<bar>set nonumber<bar>set rnu<bar>elseif &rnu<bar>set nornu<bar>else<bar>set number<bar>endif<cr>
noremap <silent> <Leader>n :if &rnu<bar>set nornu<bar>set nonumber<bar>elseif &number<bar>set rnu<bar>else<bar>set number<bar>endif<cr>

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

" Hit Esc twice to save all file
map <Esc><Esc> :wall<CR>

" Jump to end of line / beginning of line in insert mode
inoremap <C-e> <C-o>$
inoremap <C-b> <C-o>^

" Esc with jkj or kjj insert mode
"imap jkj <Esc>
"imap kjj <Esc>

"------------------------------------------
" plugin-specific settings
"------------------------------------------


"
" --- GitGutter ---
"

nnoremap <leader>gg ::GitGutterToggle<CR>

"
" --- YouCompleteMe ---
"

" don't seek confirmation every time ycm_conf file is found
" let g:ycm_confirm_extra_conf = 0

" default compilation flags for Ycm
" let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_extra_conf.py"

let g:ycm_auto_trigger = 1


" go to definition of variable/type/function under cursor
nnoremap <leader>d  ::YcmCompleter GoTo<CR>
" print type of symbol under the cursor
nnoremap <leader>t  ::YcmCompleter GetType<CR>
" Go to include file on current line
nnoremap <leader>o  ::YcmCompleter GoToInclude<CR>
" Apply YCM FixIt
nnoremap <leader>f ::YcmCompleter FixIt<CR>
" refactor the name under the cursor
nnoremap <leader>r  ::YcmCompleter RefactorRename<space>

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" always add preview to completeopt to have a function preview
let g:ycm_add_preview_to_completeopt = 1

highlight YcmWarningSign    ctermfg=yellow
highlight YcmWarningSection ctermfg=yellow
highlight YcmErrorSign      ctermfg=red
highlight YcmErrorSection   ctermfg=red

highlight YcmWarningSection cterm=bold
highlight YcmErrorSection   cterm=bold

" ----- Airline ------
" tab labeling ([tab number] filename modifiedPlusSign)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#atbline#show_buffers = 0
" let g:airline#extensions#tabline#fnamemod = ':t'


" --- ctrlp ---
" configure ctrlp to use ag for searching
" this interacts nicely with the gitignore vim package
let g:ctrlp_use_caching = 0
let g:ctrlp_cmd = 'CtrlPMixed'
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ackprg = 'ag --vimgrep'
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" --- lh-bracket ---
" delete empty placeholders when we jump to them
"let g:marker_select_empty_marks = 0

" ---- Altr settings -----
"call altr#define('%/src/%.cpp', '%/include/%.h')
"nmap <F2> <Plug>(altr-forward)
