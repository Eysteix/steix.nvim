-- ============================================================================
-- COPILOT.VIM AUTO-DISABLE ON QUOTA EXCEEDED (Neovim Lua)
-- ============================================================================
-- This configuration automatically disables GitHub Copilot when your quota
-- is exceeded, preventing annoying error messages and failed completion attempts.
--
-- Add this to your ~/.config/nvim/lua/config/copilot-auto-disable.lua
-- Then require it in your init.lua: require('config.copilot-auto-disable')
-- ============================================================================

local M = {}

-- State tracking
M.trueauto_disabled = false
M.last_check = 0
M.check_interval = 5 -- seconds

-- ----------------------------------------------------------------------------
-- Core Functions
-- ----------------------------------------------------------------------------

--- Check if Copilot has hit quota/rate limit
local function check_copilot_status()
	-- Only check if Copilot is loaded
	if not vim.g.loaded_copilot then
		return
	end

	-- Only check if enabled
	if not vim.g.copilot_enabled then
		return
	end

	-- Rate limit checks (don't check too frequently)
	local now = os.time()
	if now - M.last_check < M.check_interval then
		return
	end
	M.last_check = now

	-- Try to call Copilot status check
	local ok, result = pcall(vim.fn["copilot#Call"], "checkStatus", {})

	if not ok then
		local error_msg = tostring(result)

		-- Check for quota/rate limit errors
		if
		    error_msg:match("quota")
		    or error_msg:match("rate.?limit")
		    or error_msg:match("402")
		    or error_msg:match("limit.?exceeded")
		then
			M.disable_copilot("Quota or rate limit exceeded")
		end
	end
end

--- Disable Copilot and show message
function M.disable_copilot(reason)
	-- Only disable if currently enabled
	if not vim.g.copilot_enabled then
		return
	end

	vim.g.copilot_enabled = 0

	-- Show message only once
	if not M.auto_disabled then
		M.auto_disabled = true

		vim.notify(
			string.format("Copilot auto-disabled: %s\nRun :CopilotEnable to re-enable", reason),
			vim.log.levels.WARN,
			{ title = "Copilot" }
		)
	end
end

--- Re-enable Copilot
function M.enable_copilot()
	vim.g.copilot_enabled = 1
	M.auto_disabled = false
	vim.notify("Copilot re-enabled!", vim.log.levels.INFO, { title = "Copilot" })
end

--- Toggle Copilot on/off
function M.toggle_copilot()
	if vim.g.copilot_enabled == 1 or vim.g.copilot_enabled == nil then
		vim.g.copilot_enabled = 0
		M.auto_disabled = false
		vim.notify("Copilot disabled", vim.log.levels.INFO, { title = "Copilot" })
	else
		M.enable_copilot()
	end
end

--- Show Copilot status
function M.show_status()
	if not vim.g.loaded_copilot then
		vim.notify("Copilot plugin not loaded", vim.log.levels.WARN)
		return
	end

	local enabled = vim.g.copilot_enabled ~= 0
	local status = enabled and "ENABLED" or "DISABLED"
	local level = enabled and vim.log.levels.INFO or vim.log.levels.WARN

	local msg = string.format("Copilot: %s", status)
	if not enabled and M.auto_disabled then
		msg = msg .. "\n(Auto-disabled due to quota/rate limit)\nRun :CopilotEnable to re-enable"
	end

	vim.notify(msg, level, { title = "Copilot Status" })
end

-- ----------------------------------------------------------------------------
-- Setup Function
-- ----------------------------------------------------------------------------

function M.setup(opts)
	opts = opts or {}

	-- Optional: Start with Copilot disabled
	if opts.start_disabled then
		vim.g.copilot_enabled = 0
	end

	-- Optional: Disable for large files
	if opts.disable_for_large_files ~= false then
		local max_size = opts.max_file_size or 100000 -- 100KB default

		vim.api.nvim_create_autocmd("BufReadPre", {
			group = vim.api.nvim_create_augroup("CopilotLargeFiles", { clear = true }),
			callback = function()
				local file = vim.fn.expand("<afile>")
				local size = vim.fn.getfsize(file)

				if size > max_size or size == -2 then
					vim.b.copilot_enabled = false
				end
			end,
		})
	end

	-- Optional: Only enable for specific filetypes
	if opts.filetypes then
		vim.g.copilot_filetypes = opts.filetypes
	end

	-- Create autocommands for status checking
	local group = vim.api.nvim_create_augroup("CopilotAutoDisable", { clear = true })

	-- Check on InsertLeave (after you stop typing)
	vim.api.nvim_create_autocmd("InsertLeave", {
		group = group,
		callback = check_copilot_status,
	})

	-- Check when entering a buffer
	vim.api.nvim_create_autocmd("BufEnter", {
		group = group,
		callback = check_copilot_status,
	})

	-- Optional: Periodic check with timer (more aggressive)
	if opts.use_periodic_check then
		local interval = (opts.check_interval or 30) * 1000 -- convert to ms
		vim.fn.timer_start(interval, function()
			check_copilot_status()
		end, { ["repeat"] = -1 })
	end

	-- Create user commands
	vim.api.nvim_create_user_command("CopilotEnable", M.enable_copilot, {
		desc = "Re-enable Copilot after auto-disable",
	})

	vim.api.nvim_create_user_command("CopilotToggle", M.toggle_copilot, {
		desc = "Toggle Copilot on/off",
	})

	vim.api.nvim_create_user_command("CopilotStatus", M.show_status, {
		desc = "Show Copilot status",
	})

	-- Optional: Setup keybindings
	if opts.setup_keymaps ~= false then
		local keymap = vim.keymap.set
		local leader = opts.keymap_prefix or "<leader>c"

		keymap("n", leader .. "t", M.toggle_copilot, { desc = "Toggle Copilot" })
		keymap("n", leader .. "e", M.enable_copilot, { desc = "Enable Copilot" })
		keymap("n", leader .. "s", M.show_status, { desc = "Copilot Status" })
	end
end

-- ----------------------------------------------------------------------------
-- Default Setup (if called directly)
-- ----------------------------------------------------------------------------

M.setup()

return M
