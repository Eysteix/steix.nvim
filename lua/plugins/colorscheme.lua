return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {

			highlight_overrides = {
				all = function(colors)
					return {
						BufferLineIndicatorSelected = {
							sp = "#00A342",
							fg = "#000000",
							underline = true,
						},
					}
				end,
			},
			term_colors = true,
			transparent_background = true,
			dim_inactive = {
				enabled = false, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				treesitter = true,
				harpoon = true,
				telescope = true,
				snacks = true,
				mason = true,
				noice = true,
				bufferline = false,
				notify = true,
				which_key = true,
				fidget = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				mini = {
					enabled = true,
					indentscope_color = "",
				},
			},
		},
	},
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
	},
	{
		"audibleblink/hackthebox.vim",
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
