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
