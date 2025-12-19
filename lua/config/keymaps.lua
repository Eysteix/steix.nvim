vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = "Lazy Extension" })
vim.keymap.set("n", "<leader>ms", "<cmd>Mason<cr>", { desc = "Mason" })

-- Vim keymaps
local map = vim.keymap.set
map("n", "<C-h>", "<C-w>h", { desc = "Go to window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to window right" })
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
map(
	"n",
	"<leader>ba",
	":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>",
	{ desc = "Close all buffers except current" }
)
map("n", "<leader>fm", function()
	vim.lsp.buf.format({ async = false })
end, { desc = "format file" })
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
-- 	callback = function()
-- 		vim.lsp.buf.code_action({
-- 			apply = true,
-- 			context = {
-- 				only = { "source.organizeImports" },
-- 				diagnostics = {},
-- 			},
-- 		})
-- 		vim.lsp.buf.code_action({
-- 			apply = true,
-- 			context = { only = { "source.fixAll" }, diagnostics = {} },
-- 		})
-- 	end,
-- })
