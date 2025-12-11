return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"

		for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
			dap.adapters[adapter] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { mason_path .. "/js-debug/src/dapDebugServer.js", "${port}" },
				},
			}
		end
		local dapconfig = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch Node Program",
				program = "${file}",
				console = "integratedTerminal",
				cwd = vim.fn.getcwd(),
			},
			{
				type = "pwa-chrome",
				request = "launch",
				name = "Launch Chrome against localhost",
				url = "http://localhost:3000",
				webRoot = "${workspaceFolder}",
			},
		}
		dap.configurations.javascript = dapconfig
		dap.configurations.typescript = dapconfig

		-- 4. DAP UI listeners (These were correct, just moved for flow)
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		-- keymaps for Dap
		vim.keymap.set("n", "<Leader>bp", function()
			dap.toggle_breakpoint()
		end, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<Leader>dr", function()
			dap.continue()
		end, { desc = "DAP Continue/Run" })

		vim.keymap.set("n", "<Leader>du", function()
			dapui.toggle()
		end, { desc = "DAP Toggle" })

		dap.set_log_level("TRACE")
	end,
}
