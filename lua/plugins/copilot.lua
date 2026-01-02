return {
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			"copilotlsp-nvim/copilot-lsp",
			enabled = false,
			init = function()
				vim.g.copilot_nes_debounce = 500
			end,
		},
		enabled = false,
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				nes = {
					enabled = true,
					keymap = {
						accept_and_goto = "<leader>p",
						accept = false,
						dismiss = "<Esc>",
					},
				},
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		keys = { { "<Leader>cc", "<cmd>CopilotChat<CR>", desc = "CopilotChat" } },
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
