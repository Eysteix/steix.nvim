return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#1a1b26',
				base01 = '#1a1b26',
				base02 = '#9498a0',
				base03 = '#9498a0',
				base04 = '#eff4ff',
				base05 = '#f8faff',
				base06 = '#f8faff',
				base07 = '#f8faff',
				base08 = '#ff9eb9',
				base09 = '#ff9eb9',
				base0A = '#91b4ff',
				base0B = '#a4ffb2',
				base0C = '#c4d7ff',
				base0D = '#91b4ff',
				base0E = '#a4c1ff',
				base0F = '#a4c1ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#9498a0',
				fg = '#f8faff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#91b4ff',
				fg = '#1a1b26',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#9498a0' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#c4d7ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#a4c1ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#91b4ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#91b4ff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#c4d7ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a4ffb2',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#eff4ff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#eff4ff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#9498a0',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
