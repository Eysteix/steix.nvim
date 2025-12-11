require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "json", "http", "prisma", "php", "blade", "html", "css", "scss", "cpp", "c" },
	dotfiles = true,
	ignore = false,

	modules = {},
	sync_install = true,
	ignore_install = {},
	auto_install = true,
	indent = { enable = true },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	rainbow = {
		enabled = true,
		extended_mode = true,
		max_file_lines = nil,
	},
})

require("Comment").setup()

require("lazydev").setup({
	library = { "nvim-dap-ui" },
})
require("dapui").setup()
