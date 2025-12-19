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
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.cmdheight = 0
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "none", nocombine = true })
-- 		vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#316c71", bg = "none", nocombine = true })
-- 	end,
-- })
--Diagnostics
vim.diagnostic.config({
	virtual_text = {
		enabled = false,
		prefix = " ",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
})
vim.opt.relativenumber = true

--Theming
vim.cmd.colorscheme("catppuccin-mocha")
vim.o.cursorline = true
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#878dfe", bold = true, italic = true })
vim.opt.wrap = false
