if &compatible
  set nocompatible
endif

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
" Editing
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
" Languages
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'evanleck/vim-svelte', { 'for': 'svelte' }
Plug 'Quramy/vim-js-pretty-template', { 'for': ['javascript', 'typescript'] }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'SiegeEngineers/vim-aoe2-rms', { 'for': 'rms', 'branch': 'default' }
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'ziglang/zig.vim', { 'for': 'zig' }
Plug 'udalov/kotlin-vim', { 'for': 'kt' }

" Language server support
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

call plug#end()

" Show matches when autocompleting file names
set wildmenu

" Syntax Highlighting
filetype on
filetype indent on
filetype plugin on
syntax enable
autocmd! User vim-js-pretty-template call jspretmpl#register_tag('html', 'html')
autocmd! User vim-js-pretty-template call jspretmpl#register_tag('css', 'css')
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

" Language servers

if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
        \ 'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact', 'typescript']
        \ })
endif

if executable("rust-analyzer")
  au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'whitelist': ['rust'],
        \ })
elseif executable("rls")
  au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

if executable('ccls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'ccls',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'ccls -log-file=/tmp/ccls.log -v=1']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.ccls-root'))},
        \ 'initialization_options': { 'cache': { 'directory': expand('~/.cache/ccls') }, 'compilationDatabaseDirectory': 'build' },
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
        \ })
endif

if executable('jdtls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'jdtls',
        \ 'cmd': {server_info->['jdtls']},
        \ 'whitelist': ['java'],
        \ })
endif
