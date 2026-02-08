return {
	
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

}
