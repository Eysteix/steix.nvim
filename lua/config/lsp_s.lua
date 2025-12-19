vim.lsp.config("intelephense", {
	on_attach = function(client, bufnr)
		print("Intellsense for PHP attached")
	end,
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	filetypes = { "php" },
})

vim.lsp.config("laravel_ls", {
	on_attach = function(client, bufnr)
		print("Laravel for PHP attached")
	end,
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	filetypes = { "php", "inc" },
})

vim.lsp.config("qmlls", {
	on_attach = function()
		print("QML LSP attached!")
	end,
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	filetypes = { "qml", "qt", "qmljs" },
})

vim.lsp.config("ts_ls", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	on_attach = function(client, bufnr)
		print("TypeScript LSP attached!")
	end,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
})

vim.lsp.config("angularls", {
	on_attach = function(client, bufnr)
		print("Angular LSP attached!")
	end,
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	filetypes = { "html", "typescript", "javascript" },
})

vim.lsp.config("html", {
	filetypes = { "html" },
})

vim.lsp.config("copilot", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	on_attach = function(client, bufnr)
		print("Copilot LSP attached!")
	end,
})
vim.lsp.config("emmet_ls", {
	on_attach = function(client, bufnr)
		print("Emmet AutoComplete")
	end,
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	filetypes = {
		"css",
		"eruby",
		"html",
		"javascript",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"svelte",
		"pug",
		"typescriptreact",
		"vue",
	},
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["output.selfClosingStyle"] = "xhtml",
			},
		},
	},
})

vim.lsp.config("tailwindcss", {
	on_attach = function(client, bufnr)
		print("Tailwind Lsp")
	end,
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	filetypes = { "html", "typescriptreact", "typescript.tsx", "javascriptreact", "javascript.jsx" },
})
vim.lsp.config("prismals", {
	on_attach = function(client, bufnr)
		print("Prisma LSP attached!")
	end,
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	filetypes = { "prisma" },
})

vim.lsp.config("lua_ls", {
	on_attach = function(client, bufnr)
		print("lua lsp attached")
	end,
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	filetypes = { "lua" },
})

vim.lsp.config("biome", {
	on_attach = function(client, bufnr)
		print("biome lsp attached")
	end,
	capabilities = require("blink.cmp").get_lsp_capabilities(),
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx", "jsonc", "json" },
})

vim.lsp.config("cssls", {
	on_attach = function(client, bufnr)
		print("CSS LSP attached!")
	end,
capabilities = require("blink.cmp").get_lsp_capabilities(),
	filetypes = { "css", "scss", "less" },
	settings = {
		css = {
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
})

vim.lsp.enable("cssls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("ts_ls")
vim.lsp.enable("prismals")
vim.lsp.enable("html")
vim.lsp.enable("qmlls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("emmet_ls")
vim.lsp.enable("angularls")
vim.lsp.enable("intelephense")
vim.lsp.enable("laravel_ls")
vim.lsp.enable("biome")
vim.lsp.enable("copilot")
