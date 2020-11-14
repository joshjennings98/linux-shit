""" Josh's .vimrc

""" basic settings

set wrap                            " wrap lines
syntax on                           " show syntax
set mouse=a                         " enable mouse support
set wildmenu                        " add command completion with tab
set linebreak                       " don't break in middle of word
set title                           " reflect name of file in window title

" move down visually rather than skipping wrapped lines (may need to modify <UP> <Down> if using omnifunc)
nmap j gj
nmap <Down> gj
imap <Down> <C-o>gj
" same as above but for up
nmap k gk                           
nmap <Up> gk
imap <Up> <C-o>gk

set backspace=indent,eol,start      " allow backspacing over indention, line breaks and insertion start.
set confirm                         " confirm when closing unsaved file
set history=1000                    " increase history limit

""" tab settings

set tabstop=4                       " width of tab
set expandtab                       " tabs == spaces
set shiftwidth=4                    " number of spaces for auto indent
set softtabstop=4                   " backspace after tab removes this many spaces
set shiftround                      " round indent to nearest multiple of shiftwidth
set smarttab                        " insert tabstop number of spaces then pressing tab
set autoindent                      " copy indent from current line
set smartindent                     " smart indent (e.g. indent after '{')

""" search settings

set incsearch                       " search as characters entered
set hlsearch                        " highlight matches
set ignorecase                      " ignore the case in search
set smartcase                       " unless upper case is used

" turn off seach highlighting after carriage return
nnoremap <CR> :nohlsearch<CR><CR>

""" ui settings

set number                          " show line numbers
set ruler                           " show line and column number in bottom right corner
set laststatus=2                    " always show statusbar
hi StatusLine ctermbg=7 ctermfg=4   " change colour of statusbar so its white on blue

""" load plugins

" YouCompleteMe needs g++-8, and vim8.1 and cmake to be installed.
" As well as this, you need to go into ~/.vim/plugged/YouCompleteMe and run 
" CXX="/usr/bin/g++-8" ./install --clang-completer for it to work
" YCM-Generator needs clang installed. 
" Once installed, given a makefile exists, you can run :YcmGenerateConfig to
" generate .ycm_extra_conf.py for project. This is used for autocomplete with ycm.

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" load plugins using vim-plug
call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'           " linter (in cpp files it is overridden by ycm? need to check)
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'} " generate .ycm_extra_conf.py
Plug 'ycm-core/YouCompleteMe'       " code completion and more
"Plug 'ajh17/VimCompletesMe'        " for basic autocomplete if YCM not available

call plug#end()

""" plugin specific settings

let g:ycm_confirm_extra_conf = 0    " Get rid of annoying .ycm_extra_conf.py message
let g:ycm_autoclose_preview_window_after_completion = 1 " auto close ycm preview

