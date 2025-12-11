vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = "Lazy Extension" })

-- Vim keymaps
local map = vim.keymap.set
map("n", "<C-h>", "<C-w>h", { desc = "Go to window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to window right" })
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })
map("n", "<leader>fm", function()
	vim.lsp.buf.format({ async = false })
end, { desc = "format file" })
