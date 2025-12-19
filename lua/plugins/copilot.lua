return {
	{
		"github/copilot.vim",
		cmd = "Copilot",
	},
	-- {
	-- 	"copilotlsp-nvim/copilot-lsp",
	-- 	init = function()
	-- 		vim.g.copilot_nes_debounce = 500
	-- 		vim.lsp.enable("copilot_ls")
	-- 		vim.keymap.set("n", "<C-CR>", function()
	-- 			local bufnr = vim.api.nvim_get_current_buf()
	-- 			local state = vim.b[bufnr].nes_state
	-- 			if state then
	-- 				local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
	-- 					or (
	-- 						require("copilot-lsp.nes").apply_pending_nes()
	-- 						and require("copilot-lsp.nes").walk_cursor_end_edit()
	-- 					)
	-- 				return nil
	-- 			else
	-- 				-- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
	-- 				return "<C-i>"
	-- 			end
	-- 		end, { desc = "Accept Copilot NES suggestion", expr = true })
	-- 	end,
	-- },
	--
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			window = {
				position = "right",
				width = 0.33,
				border = "rounded",
				layout = "vertical",
			},
		},
	},
}
