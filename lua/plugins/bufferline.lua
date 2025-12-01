return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",

	config = function()
		require("bufferline").setup({
			options = {
				separator_style = "slant",
				indicator = { style = "underline" },
				show_tab_indicators = true,
				diagnostics = "nvim_lsp",
				groups = {
					{
						name = "current tab",
						scope = "tab",
					},
					items = {},
				},
				offsets = {
					{
						filetype = "snacks_layout_box",
						text = "File Explorer",
						text_align = "center",
						highlight = "Directory",
						separator = true, -- use a "true" to enable the default, or set your own character
					},
				},
			},
		})
	end,
	opts = function(_, opts)
		if (vim.g.colors_name or ""):find("catppuccin") then
			opts.highlights = require("catppuccin.special.bufferline").get_theme()
		end
	end,
}
