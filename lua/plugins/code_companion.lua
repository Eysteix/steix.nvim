return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		interactions = {
			chat = {
				adapter = "copilot",
				model = "claude-sonnet-4",
			},
		},
		inline = {
			adapter = "copilot"
		},

		tools = {
			"buffer",
			"editor",
			"files",
			"terminal",
		},

		-- NOTE: The log_level is in `opts.opts`
		opts = {
			log_level = "DEBUG", -- or "TRACE"
		},
	},
}
