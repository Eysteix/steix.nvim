return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",

	config = function()
		require("bufferline").setup({

			highlights = {
				-- All components of selected buffer with same underline
				buffer_selected = {
					sp = "#9398ff",
					underline = true,
				},

				numbers_selected = {
					sp = "#9398ff",
					underline = true,
				},
				close_button_selected = {
					sp = "#9398ff",
					underline = true,
				},
				separator_selected = {
					sp = "#9398ff",
					underline = true,
				},
				modified_selected = {
					sp = "#9398ff",
					underline = true,
				},
				duplicate_selected = {
					sp = "#9398ff",
					underline = true,
				},
			},
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
}
