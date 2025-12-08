return {
	{ "github/copilot.vim" },
	{
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
	},
}
