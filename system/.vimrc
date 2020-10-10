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
