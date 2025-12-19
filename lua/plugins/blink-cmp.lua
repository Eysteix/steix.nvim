return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
	},
	version = "1.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 250,
				treesitter_highlighting = true,
			},
			list = {
				selection = {
					auto_insert = true,
					preselect = true,
				},
			},
			menu = {
				cmdline_position = function()
					if vim.g.ui_cmdline_pos ~= nil then
						local pos = vim.g.ui_cmdline_pos
						return { pos[1] - 1, pos[2] }
					end
					local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
					return { vim.o.lines - height, 0 }
				end,
				draw = {
					columns = {
						{ "kind_icon", "label", gap = 1 },
						{ "kind" },
					},
					components = {
						kind_icon = {
							text = function(item)
								local kind = require("lspkind").symbol_map[item.kind] or ""
								return kind .. " "
							end,
							highlight = "CmpItemKind",
						},
						label = {
							text = function(item)
								return item.label
							end,
							highlight = "CmpItemAbbr",
						},
						kind = {
							text = function(item)
								return item.kind
							end,
							highlight = "CmpItemKind",
						},
					},
				},
			},
		},
		keymap = {
			preset = "default",

			["<Tab>"] = {
				function(cmp)
					-- local bufnr = vim.api.nvim_get_current_buf()
					-- local nes_state = vim.b[bufnr].nes_state
					--
					-- if nes_state then
					-- 	cmp.hide()
					-- 	local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
					-- 		or (
					-- 			require("copilot-lsp.nes").apply_pending_nes()
					-- 			and require("copilot-lsp.nes").walk_cursor_end_edit()
					-- 		)
					-- 	return true
					-- end

					if cmp.is_visible() then
						return cmp.select_next()
					end

					if cmp.snippet_active() then
						return cmp.snippet_forward()
					end
				end,
				"fallback",
			},

			["<S-Tab>"] = {
				function(cmp)
					if cmp.is_visible() then
						return cmp.select_prev()
					end
					if cmp.snippet_active() then
						return cmp.snippet_backward()
					end
				end,
				"fallback",
			},

			["<CR>"] = { "accept", "fallback" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },

			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
		},
		signature = {
			enabled = true,
		},
		cmdline = {
			keymap = { preset = "inherit" },
			completion = { menu = { auto_show = false } }, -- FIXED: Changed to false
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				lsp = {
					min_keyword_length = 2,
					score_offset = 0,
				},
				path = {
					min_keyword_length = 0,
				},
				snippets = {
					min_keyword_length = 2,
				},
				buffer = {
					min_keyword_length = 5,
					max_items = 5,
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
}
