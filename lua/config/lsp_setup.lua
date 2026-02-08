vim.lsp.config("intelephense", {
	on_attach = function(client, bufnr)
		print("Intellsense for PHP attached")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "php" },
})

vim.lsp.config("laravel_ls", {
	on_attach = function(client, bufnr)
		print("Laravel for PHP attached")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "php", "inc" },
})

vim.lsp.config("qmlls", {
	on_attach = function()
		print("QML LSP attached!")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "qml", "qt", "qmljs" },
})

vim.lsp.config("ts_ls", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(client, bufnr)
		print("TypeScript LSP attached!")
	end,

	filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
})

vim.lsp.config("angularls", {
	on_attach = function(client, bufnr)
		print("Angular LSP attached!")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "html", "typescript", "javascript" },
})

vim.lsp.config("html", {
	filetypes = { "html" },
})


vim.lsp.config("tailwindcss", {
	on_attach = function(client, bufnr)
		print("Tailwind Lsp")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "html", "typescriptreact", "typescript.tsx", "javascriptreact", "javascript.jsx" },
})
vim.lsp.config("prismals", {
	on_attach = function(client, bufnr)
		print("Prisma LSP attached!")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "prisma" },
})

vim.lsp.config("lua_ls", {
	on_attach = function(client, bufnr)
		print("lua lsp attached")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "lua" },
})

vim.lsp.config("biome", {
	on_attach = function(client, bufnr)
		print("biome lsp attached")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx", "jsonc", "json" },
})

vim.lsp.config("cssls", {
	on_attach = function(client, bufnr)
		print("CSS LSP attached!")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "css", "scss", "less" },
	settings = {
		css = {
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
})

vim.lsp.config("bashls", {
	on_attach = function(client, bufnr)
		print("Scripting Ls")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = {"zsh","zshrc","bash","bashrc","sh"}
})

vim.lsp.config("javals", {
	on_attach = function(client, bufnr)
		print("Java ")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = {"java","kotlin","class"}
})




vim.lsp.enable("bashls")
vim.lsp.enable("javals")
vim.lsp.enable("cssls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("ts_ls")
vim.lsp.enable("prismals")
vim.lsp.enable("html")
vim.lsp.enable("qmlls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("angularls")
vim.lsp.enable("intelephense")
vim.lsp.enable("laravel_ls")
vim.lsp.enable("biome")
