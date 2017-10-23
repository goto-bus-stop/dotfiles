set nocompatible

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'airblade/vim-gitgutter'
Plug 'Quramy/vim-js-pretty-template'
Plug 'StanAngeloff/php.vim'

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
call jspretmpl#register_tag('html', 'html')
call jspretmpl#register_tag('css', 'css')
autocmd FileType javascript JsPreTmpl html

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'js=javascript', 'css']

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

" Undo
set undofile
if !isdirectory("/tmp/vimundo")
  call mkdir("/tmp/vimundo", "", 0700)
endif
set undodir=/tmp/vimundo

" Autocomplete

" Keymaps
map <C-n> :NERDTreeToggle<CR>
