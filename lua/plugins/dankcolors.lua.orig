return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
<<<<<<< HEAD
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
=======
				base00 = '#181825',
				base01 = '#181825',
				base02 = '#5c6370',
				base03 = '#5c6370',
				base04 = '#abb2bf',
				base05 = '#ffffff',
				base06 = '#ffffff',
				base07 = '#ffffff',
				base08 = '#e05f5f',
				base09 = '#e05f5f',
				base0A = '#abd6ff',
				base0B = '#87e086',
				base0C = '#6879af',
				base0D = '#abd6ff',
				base0E = '#4f80a9',
				base0F = '#4f80a9',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#5c6370',
				fg = '#ffffff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#abd6ff',
				fg = '#181825',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#5c6370' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#6879af', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#4f80a9',
>>>>>>> 7d0246494be8dd6b7562bed88f4f80d108d1b9b1
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
<<<<<<< HEAD
				fg = '#91b4ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#91b4ff',
=======
				fg = '#abd6ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#abd6ff',
>>>>>>> 7d0246494be8dd6b7562bed88f4f80d108d1b9b1
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
<<<<<<< HEAD
				fg = '#c4d7ff',
=======
				fg = '#6879af',
>>>>>>> 7d0246494be8dd6b7562bed88f4f80d108d1b9b1
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
<<<<<<< HEAD
				fg = '#a4ffb2',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#eff4ff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#eff4ff' })
=======
				fg = '#87e086',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#abb2bf' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#abb2bf' })
>>>>>>> 7d0246494be8dd6b7562bed88f4f80d108d1b9b1
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
<<<<<<< HEAD
				fg = '#9498a0',
=======
				fg = '#5c6370',
>>>>>>> 7d0246494be8dd6b7562bed88f4f80d108d1b9b1
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
