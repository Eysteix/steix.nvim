-- Setup PLugins and depdencies
require("config.lazy")
require("fine-cmdline").setup({
	cmdline = {
		enable_keymaps = true,
		smart_history = true,
		prompt = "$ ",
	},
	popup = {
		position = {
			row = "10%",
			col = "45%",
		},
		size = {
			width = "40%",
		},

		border = {
			style = "rounded",
		},
		-- win_options = {
		-- 	winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		-- },
	},
})
require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "json", "http", "prisma", "php", "blade", "html", "css", "scss", "cpp", "c" }, -- http needed for rest.nvim
	filters = {
		dotfiles = true,
		ignore = false,
	},
	auto_install = true,
	highlight = { enable = true },
})

vim.g.rest_nvim = {
	result_split_horizontal = false,
	result_split_in_place = false,
	skip_ssl_verification = false,
	encode_url = true,
	highlight = {
		enabled = true,
		timeout = 150,
	},
	result = {
		show_url = true,
		show_http_info = true,
		show_headers = true,
		formatters = {
			json = "jq",
			html = function(body)
				return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
			end,
		},
	},
	jump_to_request = false,
	env_file = ".env",
	custom_dynamic_variables = {},
	yank_dry_run = true,
}

require("Comment").setup()

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
	on_attach = function(client, bufnr)
		print("QML LSP attached!")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "qml", "qt", "qmljs" },
})

vim.lsp.config("ts_ls", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(client, bufnr)
		-- optional: keymaps, etc.
		print("TypeScript LSP attached!")
	end,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
})

vim.lsp.config("angularls", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(client, bufnr)
		-- optional: keymaps, etc.
		print("Angular LSP attached!")
	end,
	filetypes = { "html", "typescript", "javascript" },
})

vim.lsp.config("html", {
	filetypes = { "html" }, -- DON'T include JS/TS here
})

vim.lsp.config("emmet_ls", {
	on_attach = function(client, bufnr)
		print("Emmet AutoComplete")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "html", "typescriptreact", "typescript.tsx", "javascriptreact", "javascript.jsx" },
})
vim.lsp.config("prismals", {
	on_attach = function(client, bufnr)
		print("Prisma LSP attached!")
	end,
	filetypes = { "prisma" },
})

vim.lsp.config("lua_ls", {
	on_attach = function(client, bufnr)
		print("lua lsp attached")
	end,
	filetypes = { "lua" },
})

vim.lsp.config("eslint", {
	on_attach = function(client, bufnr)
		print("Eslint")
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		workingDirectory = { mode = "auto" },
	},
})

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

local function start_sass_watcher()
	local file = vim.fn.expand("%")
	local css = vim.fn.expand("%:r") .. ".css"

	-- Check if watcher already running for this file
	local existing = vim.fn.system("pgrep -fl 'sass --watch --no-source-map " .. file .. "'")

	if existing == "" then
		vim.fn.jobstart({ "sass", "--watch", "--no-source-map", file .. ":" .. css }, { detach = true })
		print("Started SASS watcher for " .. file)
	else
		-- Optional: notify watcher already exists
		-- print("SASS watcher already running for " .. file)
	end
end

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.scss",
	callback = start_sass_watcher,
})

vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = "Lazy Extension" })

-- Vim keymaps
local map = vim.keymap.set
map("n", ":", "<Cmd>FineCmdline<CR>", { noremap = true })
map("n", "<C-h>", "<C-w>h", { desc = "Go to window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to window right" })
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
map("n", "<leader>fm", function()
	vim.lsp.buf.format({ async = false })
end, { desc = "format file" })
--plugin Deps
vim.opt.termguicolors = true

--Diagnostics
vim.diagnostic.config({
	virtual_text = {
		-- Set to true to enable virtual text
		enabled = true,
		-- Optional: customize the prefix text that appears before the message
		-- For example: "Error: " or "Warning: "
		-- Setting it to " " makes the message start right after the code.
		prefix = " ",

		-- Optional: You can set the severity levels that display virtual text
		-- severity = { min = vim.diagnostic.severity.WARN }, -- only shows WARN and above
	},
	-- Other useful settings you might want to ensure are on:
	signs = true, -- Show 'E', 'W', 'I' in the sign column
	underline = true, -- Underline the problematic code
	update_in_insert = false, -- Don't update diagnostics while in Insert mode
})
