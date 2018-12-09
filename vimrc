set nocompatible

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
" Editing
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" Languages
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/vim-js-pretty-template'
Plug 'posva/vim-vue'
Plug 'StanAngeloff/php.vim'
Plug 'cespare/vim-toml'
Plug 'dart-lang/dart-vim-plugin'

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
autocmd FileType javascript JsPreTmpl

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'js=javascript', 'css', 'php', 'typescript', 'c', 'cpp']
let g:javascript_plugin_flow = 1 " Enable flow type highlighting

" highlight trailing whitespace
match ErrorMsg '\s\+$'

" Tabs
set showtabline=2

" Indent fun
set autoindent
set smartindent

set expandtab
set smarttab

set tabstop=3
set shiftwidth=2

" Disable line numbers
set nonumber

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
