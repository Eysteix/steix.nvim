return {
	{
		"Shobhit-Nagpal/nvim-rafce",
		config = function()
			require("rafce")
		end,
	},
	{

		"folke/edgy.nvim",
		opts = function(_, opts)
			for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
				opts[pos] = opts[pos] or {}
				table.insert(opts[pos], {
					ft = "snacks_terminal",
					size = { height = 0.4 },
					title = "%{b:snacks_terminal.id}: %{b:term_title}",
					filter = function(_buf, win)
						return vim.w[win].snacks_win
							and vim.w[win].snacks_win.position == pos
							and vim.w[win].snacks_win.relative == "editor"
							and not vim.w[win].trouble_preview
					end,
				})
			end
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = function(_, opts)
			return require("indent-rainbowline").make_opts(opts)
		end,
		dependencies = {
			"TheGLander/indent-rainbowline.nvim",
		},
	},
	{
		"ricardoramirezr/blade-nav.nvim",
		dependencies = {
			"hrsh7th/nvim-cmp",
			{ "ms-jpq/coq_nvim", branch = "coq" },
		},
		ft = { "blade", "php" },
		opts = {
			close_tag_on_complete = true,
		},
	},

	{
		"adalessa/laravel.nvim",
		dependencies = {
			"tpope/vim-dotenv",
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/nvim-nio",
			"ravitemer/mcphub.nvim",
		},
		cmd = { "Laravel" },
		keys = {
			{
				"<leader>ll",
				function()
					Laravel.pickers.laravel()
				end,
				desc = "Laravel: Open Laravel Picker",
			},
			{
				"<c-g>",
				function()
					Laravel.commands.run("view:finder")
				end,
				desc = "Laravel: Open View Finder",
			},
			{
				"<leader>la",
				function()
					Laravel.pickers.artisan()
				end,
				desc = "Laravel: Open Artisan Picker",
			},
			{
				"<leader>lt",
				function()
					Laravel.commands.run("actions")
				end,
				desc = "Laravel: Open Actions Picker",
			},
			{
				"<leader>lr",
				function()
					Laravel.pickers.routes()
				end,
				desc = "Laravel: Open Routes Picker",
			},
			{
				"<leader>lh",
				function()
					Laravel.run("artisan docs")
				end,
				desc = "Laravel: Open Documentation",
			},
			{
				"<leader>lm",
				function()
					Laravel.pickers.make()
				end,
				desc = "Laravel: Open Make Picker",
			},
			{
				"<leader>lc",
				function()
					Laravel.pickers.commands()
				end,
				desc = "Laravel: Open Commands Picker",
			},
			{
				"<leader>lo",
				function()
					Laravel.pickers.resources()
				end,
				desc = "Laravel: Open Resources Picker",
			},
			{
				"<leader>lp",
				function()
					Laravel.commands.run("command_center")
				end,
				desc = "Laravel: Open Command Center",
			},
			{
				"gf",
				function()
					local ok, res = pcall(function()
						if Laravel.app("gf").cursorOnResource() then
							return "<cmd>lua Laravel.commands.run('gf')<cr>"
						end
					end)
					if not ok or not res then
						return "gf"
					end
					return res
				end,
				expr = true,
				noremap = true,
			},
		},
		event = { "VeryLazy" },
		opts = {
			features = {
				pickers = {
					provider = "snacks",
				},
			},
		},
	},
	{
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
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"nvim-lua/popup.nvim",
	},
	{
		"barrett-ruth/live-server.nvim",
		build = "bun add -g live-server",
		cmd = { "LiveServerStart", "LiveServerStop" },
		config = true,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
	},

	{
		"arminveres/md-pdf.nvim",
		branch = "main",
		lazy = true,
		keys = {
			{
				"<leader>,",
				function()
					require("md-pdf").convert_md_to_pdf()
				end,
				desc = "Markdown preview",
			},
		},
	},
	{
		"adelarsq/image_preview.nvim",
		event = "VeryLazy",
		config = function()
			require("image_preview").setup()
		end,
	},

	{
		"numToStr/Comment.nvim",
	},
	{
		"kosayoda/nvim-lightbulb",
		config = function()
			require("nvim-lightbulb").setup({
				on_attach = function()
					print("lightbulb")
				end,

				vim.keymap.set("n", "<leader>lb", vim.lsp.buf.code_action, { desc = "Code Action" }),
			})
		end,
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
		opts = {
			rocks = {
				"nvim-nio",
				"lua-curl",
				"lua-language-server",
				"fidget",
				"mimetypes",
				"xml2lua",
				"luarocks-build-tree-sitter",
			},
		},
	},
	{
		"echasnovski/mini.icons",
		opts = {},
		lazy = true,
		specs = {
			{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
		opts = {
			preset = "nvim-remote",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			})
		end,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = false,
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "ts_ls", "cssls", "html", "intelephense" },
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Main completion settings
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	{
		"rest-nvim/rest.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "http")
			end,
		},
	},
}
