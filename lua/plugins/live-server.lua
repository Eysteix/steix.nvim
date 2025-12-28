return {
	"barrett-ruth/live-server.nvim",
	build = "bun add -g live-server",
	cmd = { "LiveServerStart", "LiveServerStop" },
	keys = {
		{
			"<leader>ls",
			"<cmd>LiveServerToggle<cr>",
			desc = "LiveServerToggle",
		},
	},
	config = true,
}
