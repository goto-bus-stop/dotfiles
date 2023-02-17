if &compatible
  set nocompatible
endif

let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
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
Plug 'phpactor/phpactor', { 'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'SiegeEngineers/vim-aoe2-rms', { 'for': 'rms', 'branch': 'default' }
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'ziglang/zig.vim', { 'for': 'zig' }
Plug 'udalov/kotlin-vim', { 'for': 'kt' }

" Language server support
if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'neovim/nvim-lspconfig'
else
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
endif

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

if has('nvim')
  lua << EOF
    local lsp = require('lspconfig')
    local eslint = {
      lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
      lintStdin = true,
      lintFormats = {'%f:%l:%c: %m'},
      lintIgnoreExitCode = true,
      formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
      formatStdin = true
    }

    local keybinds = function(bufnr)
      vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, { noremap = true, silent = true })
      vim.keymap.set('n', 'gD', vim.lsp.buf.definition, { noremap = true, silent = true })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })
      vim.keymap.set('n', 'gR', vim.lsp.buf.rename, { noremap = true, silent = true })
    end

    lsp.rust_analyzer.setup {
      on_attach = function(client, bufnr)
        keybinds(bufnr)
      end
    }
    lsp.tsserver.setup {
      on_attach = function(client, bufnr)
        if client.config.flags then
          client.config.flags.allow_incremental_sync = true
        end
        client.resolved_capabilities.document_formatting = false

        keybinds(bufnr)
      end
    }
    lsp.efm.setup {
      on_attach = function(client)
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.goto_definition = false
      end,
      root_dir = function()
        local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)
        if vim.tbl_isempty(eslintrc) then
          return nil
        end
        return vim.fn.getcwd()
      end,
      settings = {
        languages = {
          javascript = {eslint},
          javascriptreact = {eslint},
          ['javascript.jsx'] = {eslint},
          typescript = {eslint},
          ['typescript.tsx'] = {eslint},
          typescriptreact = {eslint}
        }
      },
      filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescript.tsx',
        'typescriptreact'
      },
    }
    lsp.phpactor.setup {
      on_attach = function(client, bufnr)
        keybinds(bufnr)
      end
    }

    require('nvim-treesitter.configs').setup {
      highlight = { enable = true },
      indent = { enable = true }
    }
EOF
else
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
endif
