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
	-- Theme
	'dracula/vim',

	'tpope/vim-repeat',
	'tpope/vim-commentary',
	'tpope/vim-surround',

	'nvim-treesitter/nvim-treesitter',
	'neovim/nvim-lspconfig',
	'mrcjkb/rustaceanvim',

	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/nvim-cmp',

	'hrsh7th/cmp-vsnip',
	'hrsh7th/vim-vsnip',
})

vim.cmd 'colorscheme dracula'

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
	vim.keymap.set('n', 'gA', vim.lsp.buf.code_action, { noremap = true, silent = true })
end

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
	ensure_installed = {
		'javascript',
		'tsx',
		'typescript',
		'html',
		'css',
		'vue',
		'json',
		'markdown',
		'rust',
		'glsl',
	},
	highlight = { enable = true },
	indent = { enable = true }
}

local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})
