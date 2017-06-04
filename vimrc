set nocompatible

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'editorconfig/editorconfig-vim'
" Plug 'valloric/youcompleteme'
Plug 'pangloss/vim-javascript'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'Quramy/vim-js-pretty-template'

let g:rainbow_active = 1
Plug 'luochen1990/rainbow'

call plug#end()

" Show matches when autocompleting file names
set wildmenu

" Syntax Highlighting
filetype on
filetype indent on
filetype plugin on
syntax enable
autocmd BufReadPost * call jspretmpl#applySyntax('html', 'html`')
autocmd BufReadPost * call jspretmpl#applySyntax('css', 'css`')

" Tabs
set showtabline=2

" Indent fun
set autoindent
set smartindent

set expandtab
set smarttab

set tabstop=3
set shiftwidth=2

" Enable line numbers
set number

" Searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite     " ignore all whitespace and sync

" Autocomplete

" Statusline
set laststatus=2

" Keymaps
map <C-n> :NERDTreeToggle<CR>
