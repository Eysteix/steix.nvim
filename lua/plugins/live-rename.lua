return {
	"saecki/live-rename.nvim",
	config = function()
		local live_rename = require("live-rename")
		vim.keymap.set("n", "<leader>r", live_rename.rename, { desc = "LSP rename" })
	end,
}
