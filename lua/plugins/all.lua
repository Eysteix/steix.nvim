return {
	{
		"folke/edgy.nvim",
		---@module 'edgy'
		---@param opts Edgy.Config
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
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = function(_, opts)
			-- Other blankline configuration here
			return require("indent-rainbowline").make_opts(opts)
		end,
		dependencies = {
			"TheGLander/indent-rainbowline.nvim",
		},
	},
	{
		"ricardoramirezr/blade-nav.nvim",
		dependencies = { -- totally optional
			"hrsh7th/nvim-cmp", -- if using nvim-cmp
			{ "ms-jpq/coq_nvim", branch = "coq" }, -- if using coq
			"saghen/blink.cmp", -- if using blink.cmp
		},
		ft = { "blade", "php" }, -- optional, improves startup time
		opts = {
			-- This applies for nvim-cmp and coq, for blink refer to the configuration of this plugin
			close_tag_on_complete = true, -- default: true
		},
	},

	{
		"adalessa/laravel.nvim",
		dependencies = {
			"tpope/vim-dotenv",
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/nvim-nio",
			"ravitemer/mcphub.nvim", -- optional
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
					provider = "snacks", -- "snacks | telescope | fzf-lua | ui-select"
				},
			},
		},
	},
	{ -- lazy
		"ccaglak/namespace.nvim",
		-- keys = {
		--   { "<leader>la", "<cmd>Php classes<cr>" },
		--   { "<leader>lc", "<cmd>Php class<cr>" },
		--   { "<leader>ln", "<cmd>Php namespace<cr>" },
		--   { "<leader>ls", "<cmd>Php sort<cr>" },
		-- },
		dependencies = {
			"ccaglak/phptools.nvim", -- optional
			"ccaglak/larago.nvim", -- optional
		},
		config = function()
			require("namespace").setup({
				ui = true, -- default: true -- false only if you want to use your own ui
				cacheOnload = false, -- default: false -- cache composer.json on load
				dumpOnload = false, -- default: false -- dump composer.json on load
				sort = {
					on_save = false, -- default: false -- sorts on every search
					sort_type = "length_desc", -- default: natural -- seam like what pint is sorting
					--  ascending -- descending -- length_asc
					-- length_desc -- natural -- case_insensitive
					--
				},
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
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
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
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
			rocks = { "nvim-nio", "lua-curl", "fidget", "mimetypes", "xml2lua", "luarocks-build-tree-sitter" }, -- Specify LuaRocks packages to install
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
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		--
		--
		-- order to load the plugin when the command is run for the first time
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
				ensure_installed = { "ts_ls", "lua_ls", "cssls", "html", "intelephense" },
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",

		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},

		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier,
					require("none-ls.code_actions.eslint"),
					require("none-ls.diagnostics.eslint_d"),
				},
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source
			"hrsh7th/cmp-buffer", -- buffer words
			"hrsh7th/cmp-path", -- filesystem paths
			"saadparwaiz1/cmp_luasnip", -- snippets
			"L3MON4D3/LuaSnip", -- snippet engine
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(), -- trigger completion
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- enter to confirm
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "omni" },
				}),
				opts = {
					cmdline = {
						enabled = true,
						---@diagnostic disable-next-line: assign-type-mismatch
						sources = function()
							local type = vim.fn.getcmdtype()
							if type == "/" or type == "?" then
								return { "buffer" }
							end
							if type == ":" or type == "@" then
								return { "cmdline", "path" }
							end
							return {}
						end,
						completion = {
							menu = { auto_show = true },
							ghost_text = { enabled = false },
						},
					},
				},
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
