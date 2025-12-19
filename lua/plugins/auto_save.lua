return {
	{
		"okuuva/auto-save.nvim",
		cmd = "ASToggle",
		event = { "InsertLeave", "TextChanged" },
		opts = {
			enabled = true,
			trigger_events = {
				immediate_save = { "BufLeave", "FocusLost", "InsertLeave" },
				cancel_deferred_save = { "InsertEnter" },
			},
			debounce_delay = 5000,
		},
	},
}
