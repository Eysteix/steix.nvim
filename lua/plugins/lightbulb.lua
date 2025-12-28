return {
	"kosayoda/nvim-lightbulb",
	config = function()
		require("nvim-lightbulb").setup({
			on_attach = function()
				print("lightbulb")
			end,

			vim.keymap.set("n", "<leader>lb", vim.lsp.buf.code_action, { desc = "Code Action" }),
		})
	end,
}
