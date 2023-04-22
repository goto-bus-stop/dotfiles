local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	'tpope/vim-repeat',
	'tpope/vim-commentary',
	'tpope/vim-surround',
	-- 'folke/tokyonight.nvim',
	-- 'rebelot/kanagawa.nvim',
	'dracula/vim',

	'nvim-treesitter/nvim-treesitter',
	'neovim/nvim-lspconfig',
	'simrat39/rust-tools.nvim',
})

vim.cmd 'colorscheme dracula'

local lsp = require('lspconfig')
local rt = require('rust-tools')
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
	vim.keymap.set('n', 'gA', vim.lsp.buf.code_action, { noremap = true, silent = true })
end

rt.setup {
	server = {
		cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
		on_attach = function(client, bufnr)
			keybinds(bufnr)
			vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
		end
	}
}
lsp.tsserver.setup {
	on_attach = function(client, bufnr)
		if client.config.flags then
			client.config.flags.allow_incremental_sync = true
		end
		client.server_capabilities.document_formatting = false

		keybinds(bufnr)
	end
}
lsp.efm.setup {
	on_attach = function(client)
		client.server_capabilities.document_formatting = true
		client.server_capabilities.goto_definition = false
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
lsp.cssls.setup {
	on_attach = function(client, bufnr)
		keybinds(bufnr)
	end
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
