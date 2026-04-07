return {
	"vhyrro/luarocks.nvim",
	priority = 1000,
	config = true,
	opts = {
		rocks = {
			"nvim-nio",
			"lua-curl",
			"lua-language-server",
			"fidget",
			"plenary.nvim",
			"mimetypes",
			"xml2lua",
			"luarocks-build-tree-sitter",
		},
	},
}
