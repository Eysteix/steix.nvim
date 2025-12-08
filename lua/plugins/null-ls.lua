return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvimtools/none-ls-extras.nvim" },

	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.prettier,
			},
		})

		-- optional but recommended: format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.css", "*.scss", "*.md" },
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end,
}
