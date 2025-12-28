return {
	"ccaglak/namespace.nvim",
	-- keys = {
	--   { "<leader>la", "<cmd>Php classes<cr>" },
	--   { "<leader>lc", "<cmd>Php class<cr>" },
	--   { "<leader>ln", "<cmd>Php namespace<cr>" },
	--   { "<leader>ls", "<cmd>Php sort<cr>" },
	-- },
	dependencies = {
		"ccaglak/phptools.nvim",
		"ccaglak/larago.nvim",
	},
	config = function()
		require("namespace").setup({
			ui = true,
			cacheOnload = false,
			dumpOnload = false,
			sort = {
				on_save = false,
				sort_type = "length_desc",
			},
		})
	end,
}
