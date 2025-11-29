-- return {
-- 	"pocco81/auto-save.nvim",
-- 	lazy = false, -- load immediately
-- 	config = function()
-- 		require("auto-save").setup({
-- 			enabled = true,
-- 			execution_message = {
-- 				message = function()
-- 					return "File saved"
-- 				end,
-- 			},
-- 			debounce_delay = 1000, -- in ms
-- 		})
-- 	end,
-- }
return {
	{
		"okuuva/auto-save.nvim",
		cmd = "ASToggle",
		event = { "InsertLeave", "TextChanged" },
		opts = {
			trigger_events = {
				immediate_save = { "BufLeave", "FocusLost" },
				defer_save = { "InsertLeave" },
				cancel_deferred_save = { "InsertEnter" },
			},
			debounce_delay = 1000,
		},
	},
}
