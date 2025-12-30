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
		-- ============================================================================
		-- APPEARANCE CONFIGURATION
		-- ============================================================================
		appearance = {
			-- Don't use nvim-cmp's fallback highlights (recommended for modern themes)
			use_nvim_cmp_as_default = false,
			-- Use 'mono' for consistent icon spacing with Nerd Font Mono
			nerd_font_variant = "mono",
		},

		-- ============================================================================
		-- COMPLETION CONFIGURATION
		-- ============================================================================
		completion = {
			-- ------------------------------------------------------------------------
			-- KEYWORD MATCHING
			-- ------------------------------------------------------------------------
			keyword = {
				-- 'full' matches text before AND after cursor (more intuitive)
				-- 'prefix' only matches text before cursor
				-- Example: typing 'foo_|_bar' with 'full' will match 'foo__bar'
				range = "full",
			},

			-- ------------------------------------------------------------------------
			-- ACCEPT BEHAVIOR
			-- ------------------------------------------------------------------------
			accept = {
				auto_brackets = {
					-- Auto-add brackets for functions/methods (e.g., "function(|)")
					enabled = true,
				},
			},

			-- ------------------------------------------------------------------------
			-- TRIGGER BEHAVIOR
			-- ------------------------------------------------------------------------
			trigger = {
				-- Show completions immediately after typing keyword characters
				show_on_keyword = true,
				-- Show on LSP trigger characters (e.g., '.' for methods)
				show_on_trigger_character = true,
				-- Don't show completions inside snippets (prevents conflicts)
				-- Set to true if you want completions while editing snippets
				show_in_snippet = true,
			},

			-- ------------------------------------------------------------------------
			-- LIST BEHAVIOR (Selection & Auto-insert)
			-- ------------------------------------------------------------------------
			list = {
				selection = {
					-- Automatically select first item in completion list
					-- WHY: Faster workflow, allows immediate acceptance with <CR>
					preselect = true,

					-- Insert preview of selected item automatically
					-- WHY: You see what will be inserted before confirming
					-- Use <C-e> to cancel and undo the preview
					auto_insert = true,

					-- ADVANCED: Dynamic preselect (don't preselect while in snippet)
					-- Uncomment if you want to prevent preselection during snippet editing:
					-- preselect = function(ctx)
					-- 	return not require("blink.cmp").snippet_active({ direction = 1 })
					-- end,
				},
				-- Cycle through items (top to bottom, bottom to top)
				cycle = {
					from_top = true,
					from_bottom = true,
				},
			},

			-- ------------------------------------------------------------------------
			-- MENU APPEARANCE & LAYOUT
			-- ------------------------------------------------------------------------
			menu = {
				-- Auto-show menu when completions are available
				auto_show = true,

				-- Custom positioning for cmdline mode
				cmdline_position = function()
					if vim.g.ui_cmdline_pos ~= nil then
						local pos = vim.g.ui_cmdline_pos
						return { pos[1] - 1, pos[2] }
					end
					local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
					return { vim.o.lines - height, 0 }
				end,

				-- ----------------------------------------------------------------
				-- MENU DRAWING & COMPONENTS
				-- ----------------------------------------------------------------
				draw = {
					-- Use treesitter for syntax highlighting in LSP completions
					-- WHY: Better visual context for code completions
					treesitter = { "lsp" },

					-- Column layout: [icon + label] [kind]
					-- WHY: Clean, compact layout similar to VSCode
					columns = {
						{ "kind_icon", "label", gap = 1 },
						{ "kind" },
					},

					-- Define how each component is rendered
					components = {
						-- Icon for completion kind (Function, Variable, etc.)
						kind_icon = {
							text = function(item)
								local kind = require("lspkind").symbol_map[item.kind] or ""
								return kind .. " "
							end,
							highlight = "CmpItemKind",
						},

						-- Main label text
						label = {
							text = function(item)
								return item.label
							end,
							highlight = "CmpItemAbbr",
						},

						-- Kind text (Function, Variable, etc.)
						kind = {
							text = function(item)
								return item.kind
							end,
							highlight = "CmpItemKind",
						},
					},
				},

				-- Optional: Add borders to the menu
				-- border = "rounded",

				-- Optional: Adjust menu size
				-- max_height = 15,
				-- min_width = 20,
			},

			-- ------------------------------------------------------------------------
			-- DOCUMENTATION WINDOW
			-- ------------------------------------------------------------------------
			documentation = {
				-- Auto-show documentation for selected item
				-- WHY: Immediate context without manual triggering
				auto_show = true,

				-- Small delay before showing (prevents flicker during fast navigation)
				auto_show_delay_ms = 250,

				-- Use treesitter for code highlighting in docs
				treesitter_highlighting = true,

				-- Optional: Documentation window customization
				-- window = {
				-- 	border = "rounded",
				-- 	max_height = 20,
				-- 	max_width = 80,
				-- },
			},

			-- ------------------------------------------------------------------------
			-- GHOST TEXT (inline completion preview)
			-- ------------------------------------------------------------------------
			ghost_text = {
				-- Disabled by default (use menu preview instead via auto_insert)
				-- WHY: Menu preview is more visible and less distracting
				-- Set to true for GitHub Copilot-style inline suggestions
				enabled = false,
			},
		},

		-- ============================================================================
		-- KEYMAP CONFIGURATION
		-- ============================================================================
		keymap = {
			-- Use 'default' preset as base
			-- Other options: 'super-tab', 'enter', 'none'
			preset = "default",

			-- ------------------------------------------------------------------------
			-- TAB: Smart completion navigation + snippet jumping
			-- ------------------------------------------------------------------------
			["<Tab>"] = {
				function(cmp)
					-- Priority order:
					-- 1. If menu is visible -> select next item
					-- 2. If in snippet -> jump to next placeholder
					-- 3. Otherwise -> fallback to default Tab behavior
					if cmp.is_visible() then
						return cmp.select_next()
					elseif cmp.snippet_active() then
						return cmp.snippet_forward()
					end
				end,
				"fallback",
			},

			-- ------------------------------------------------------------------------
			-- SHIFT-TAB: Reverse of Tab
			-- ------------------------------------------------------------------------
			["<S-Tab>"] = {
				function(cmp)
					if cmp.is_visible() then
						return cmp.select_prev()
					elseif cmp.snippet_active() then
						return cmp.snippet_backward()
					end
				end,
				"fallback",
			},

			-- ------------------------------------------------------------------------
			-- ENTER: Accept selected completion
			-- ------------------------------------------------------------------------
			-- WHY: Using <CR> instead of default <C-y> for muscle memory from other editors
			["<CR>"] = { "accept", "fallback" },

			-- ------------------------------------------------------------------------
			-- CTRL-SPACE: Toggle menu + documentation
			-- ------------------------------------------------------------------------
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

			-- ------------------------------------------------------------------------
			-- CTRL-E: Cancel/hide completion
			-- ------------------------------------------------------------------------
			["<C-e>"] = { "hide", "fallback" },

			-- ------------------------------------------------------------------------
			-- ARROW KEYS: Navigate completions
			-- ------------------------------------------------------------------------
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },

			-- ------------------------------------------------------------------------
			-- CTRL-N/P: Alternative navigation (vim-style)
			-- ------------------------------------------------------------------------
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },

			-- ------------------------------------------------------------------------
			-- DOCUMENTATION SCROLLING
			-- ------------------------------------------------------------------------
			-- Using <C-d>/<C-u> instead of default <C-f>/<C-b>
			-- WHY: More intuitive for vim users (half-page scroll in normal mode)
			-- NOTE: These may conflict with vim's default buffer scrolling
			-- If conflicts occur, consider using <C-f>/<C-b> or custom mappings
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
		},

		-- ============================================================================
		-- SIGNATURE HELP CONFIGURATION
		-- ============================================================================
		signature = {
			-- Show function signature help while typing
			enabled = true,

			-- Optional: Customize signature window
			-- window = {
			-- 	border = "rounded",
			-- },
		},

		-- ============================================================================
		-- CMDLINE MODE CONFIGURATION
		-- ============================================================================
		cmdline = {
			-- Inherit keymaps from default mode
			keymap = { preset = "inherit" },

			completion = {
				menu = {
					-- Don't auto-show in cmdline (use Tab to trigger)
					-- WHY: Auto-show is distracting in command mode
					auto_show = false,
				},
			},
		},

		-- ============================================================================
		-- SOURCES CONFIGURATION
		-- ============================================================================
		sources = {
			-- Default sources for all filetypes
			default = { "lsp", "path", "snippets", "buffer" },

			-- Per-source configuration
			providers = {
				-- ----------------------------------------------------------------
				-- LSP SOURCE
				-- ----------------------------------------------------------------
				lsp = {
					-- Minimum characters before triggering LSP completions
					-- WHY: Prevents too many results for short queries
					min_keyword_length = 0,

					-- Boost LSP items in ranking (0 = neutral)
					score_offset = 0,

					-- Optional: Transform items before display
					-- transform_items = function(ctx, items)
					-- 	-- Example: Filter out snippets from LSP
					-- 	return vim.tbl_filter(function(item)
					-- 		return item.kind ~= require("blink.cmp.types").CompletionItemKind.Snippet
					-- 	end, items)
					-- end,
				},

				-- ----------------------------------------------------------------
				-- PATH SOURCE
				-- ----------------------------------------------------------------
				path = {
					-- Trigger path completions immediately
					min_keyword_length = 0,

					-- Optional: Make paths relative to CWD instead of buffer
					-- opts = {
					-- 	get_cwd = function(_)
					-- 		return vim.fn.getcwd()
					-- 	end,
					-- },
				},

				-- ----------------------------------------------------------------
				-- SNIPPETS SOURCE
				-- ----------------------------------------------------------------
				snippets = {
					min_keyword_length = 1,
					-- Boost snippet priority if desired
					-- score_offset = 5,
				},

				-- ----------------------------------------------------------------
				-- BUFFER SOURCE
				-- ----------------------------------------------------------------
				
				buffer = {
					-- Require more characters to avoid noise
					-- WHY: Buffer words can be numerous and irrelevant
					min_keyword_length = 5,

					-- Limit buffer completions
					max_items = 5,
				},
			},
		},

		-- ============================================================================
		-- FUZZY MATCHING CONFIGURATION
		-- ============================================================================
		fuzzy = {
			-- Use Rust implementation if available (faster)
			-- Falls back to Lua with warning if Rust binary unavailable
			-- WHY: Rust implementation is ~6x faster than Lua
			implementation = "prefer_rust_with_warning",

			-- Optional: Customize sorting
			-- sorts = { "score", "kind" },
		},

		-- ============================================================================
		-- SNIPPETS CONFIGURATION
		-- ============================================================================
		snippets = {
			-- Use default vim.snippet engine
			-- Other options: 'luasnip', 'mini_snippets', 'vsnip'
			preset = "default",
		},
	},
}
