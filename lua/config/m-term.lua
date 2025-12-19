-- ============================================================================
-- MULTI-TERMINAL MANAGER FOR SNACKS.NVIM
-- ============================================================================
-- This configuration allows you to create and manage multiple independent
-- terminals in different tabs, splits, and floating windows - similar to
-- what you had with Telescope's terminal picker.
--
-- Place in: ~/.config/nvim/lua/config/multi-terminal.lua
-- Require in init.lua: require('config.multi-terminal')
-- ============================================================================

local M = {}

-- Terminal registry to track all terminals
M.terminals = {}
M.next_id = 1

-- ============================================================================
-- CORE TERMINAL FUNCTIONS
-- ============================================================================

--- Create a new terminal with a unique ID
---@param opts? table Options for terminal creation
---@return number terminal_id
function M.create_terminal(opts)
	opts = opts or {}

	local term_id = M.next_id
	M.next_id = M.next_id + 1

	-- Default options
	local term_opts = vim.tbl_deep_extend("force", {
		cmd = opts.cmd,
		cwd = opts.cwd or vim.fn.getcwd(),
		env = opts.env,
		count = term_id, -- Use term_id as count to make each terminal unique
		win = {
			position = opts.position or "bottom",
			height = opts.height or 0.4,
			width = opts.width or 0.9,
		},
		interactive = true,
	}, opts)

	-- Store terminal info
	M.terminals[term_id] = {
		id = term_id,
		opts = term_opts,
		terminal = nil, -- Will be set when terminal is opened
		name = opts.name or ("Terminal " .. term_id),
		created_at = os.time(),
	}

	-- vim.notify("Created: " .. M.terminals[term_id].name, vim.log.levels.INFO)

	return term_id
end

--- Open a terminal by ID
---@param term_id number Terminal ID to open
function M.open_terminal(term_id)
	local term_info = M.terminals[term_id]
	if not term_info then
		vim.notify("Terminal " .. term_id .. " not found", vim.log.levels.ERROR)
		return
	end

	-- Use the count option to ensure we get the right terminal
	term_info.opts.count = term_id

	-- Open the terminal
	local terminal = Snacks.terminal(term_info.opts.cmd, term_info.opts)

	-- Store reference
	term_info.terminal = terminal
end

--- Toggle a terminal by ID
---@param term_id number Terminal ID to toggle
function M.toggle_terminal(term_id)
	local term_info = M.terminals[term_id]
	if not term_info then
		vim.notify("Terminal " .. term_id .. " not found", vim.log.levels.ERROR)
		return
	end

	-- Use the count option to ensure we get the right terminal
	term_info.opts.count = term_id

	Snacks.terminal.toggle(term_info.opts.cmd, term_info.opts)
end

--- Close a terminal by ID
---@param term_id number Terminal ID to close
function M.close_terminal(term_id)
	local term_info = M.terminals[term_id]
	if not term_info then
		return
	end

	if term_info.terminal then
		term_info.terminal:close()
	end
end

--- Delete a terminal by ID (removes from registry)
---@param term_id number Terminal ID to delete
function M.delete_terminal(term_id)
	M.close_terminal(term_id)
	M.terminals[term_id] = nil
	vim.notify("Deleted Terminal " .. term_id, vim.log.levels.INFO)
end

--- Open terminal in a new tab
---@param term_id number Terminal ID
function M.open_in_tab(term_id)
	vim.cmd("tabnew")
	M.open_terminal(term_id)
end

--- Open terminal in vertical split
---@param term_id number Terminal ID
function M.open_in_vsplit(term_id)
	local term_info = M.terminals[term_id]
	if not term_info then
		return
	end

	term_info.opts.win.position = "right"
	term_info.opts.win.width = 0.5
	M.open_terminal(term_id)
end

--- Open terminal in horizontal split
---@param term_id number Terminal ID
function M.open_in_split(term_id)
	local term_info = M.terminals[term_id]
	if not term_info then
		return
	end

	term_info.opts.win.position = "bottom"
	term_info.opts.win.height = 0.4
	M.open_terminal(term_id)
end

--- Open terminal in floating window
---@param term_id number Terminal ID
function M.open_in_float(term_id)
	local term_info = M.terminals[term_id]
	if not term_info then
		return
	end

	term_info.opts.win.position = "float"
	term_info.opts.win.height = 0.8
	term_info.opts.win.width = 0.8
	M.open_terminal(term_id)
end

-- ============================================================================
-- PRESET TERMINAL CONFIGURATIONS
-- ============================================================================

--- Create common terminal presets
function M.create_presets()
	-- Default shell terminal
	M.create_terminal({
		name = "Shell",
		position = "bottom",
		height = 0.4,
	})

	-- Horizontal split terminal
	M.create_terminal({
		name = "Split Terminal",
		position = "bottom",
		height = 0.3,
	})

	-- Vertical split terminal
	M.create_terminal({
		name = "Vertical Terminal",
		position = "right",
		width = 0.4,
	})

	-- Floating terminal
	M.create_terminal({
		name = "Float Terminal",
		position = "float",
		height = 0.8,
		width = 0.8,
	})
end

-- ============================================================================
-- TERMINAL PICKER (TELESCOPE-LIKE)
-- ============================================================================

--- Show picker for all terminals (using Snacks picker)
function M.pick_terminal()
	local terminals_list = {}

	-- Build list of terminals
	for id, term_info in pairs(M.terminals) do
		table.insert(terminals_list, {
			id = id,
			name = term_info.name,
			cwd = term_info.opts.cwd,
			position = term_info.opts.win.position,
			created = os.date("%Y-%m-%d %H:%M:%S", term_info.created_at),
		})
	end

	-- Sort by ID
	table.sort(terminals_list, function(a, b)
		return a.id < b.id
	end)

	-- Use vim.ui.select for picking
	vim.ui.select(terminals_list, {
		prompt = "Select Terminal:",
		format_item = function(item)
			return string.format("[%d] %s (%s) - %s", item.id, item.name, item.position, item.cwd)
		end,
	}, function(choice)
		if choice then
			-- Show submenu for actions
			local actions = {
				{ name = "Toggle",         action = M.toggle_terminal },
				{ name = "Open in Tab",    action = M.open_in_tab },
				{ name = "Open in Split",  action = M.open_in_split },
				{ name = "Open in VSplit", action = M.open_in_vsplit },
				{ name = "Open in Float",  action = M.open_in_float },
				{ name = "Close",          action = M.close_terminal },
				{ name = "Delete",         action = M.delete_terminal },
			}

			vim.ui.select(actions, {
				prompt = "Action for " .. choice.name .. ":",
				format_item = function(item)
					return item.name
				end,
			}, function(action)
				if action then
					action.action(choice.id)
				end
			end)
		end
	end)
end

-- Alternative: Simple list all terminals
function M.list_terminals()
	if vim.tbl_isempty(M.terminals) then
		vim.notify("No terminals created", vim.log.levels.WARN)
		return
	end

	local lines = { "=== Active Terminals ===" }
	for id, term_info in pairs(M.terminals) do
		table.insert(
			lines,
			string.format("[%d] %s - %s (%s)", id, term_info.name, term_info.opts.cwd,
				term_info.opts.win.position)
		)
	end

	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end

-- ============================================================================
-- QUICK ACCESS FUNCTIONS
-- ============================================================================

--- Quick function to create and open a terminal
---@param opts? table Terminal options
---@return number term_id
function M.new_terminal(opts)
	opts = opts or {}
	local term_id = M.create_terminal(opts)
	M.open_terminal(term_id)
	return term_id
end

--- Create and open terminal in new tab
function M.new_terminal_tab()
	local term_id = M.create_terminal({ name = "Tab Terminal" })
	M.open_in_tab(term_id)
	return term_id
end

--- Create and open terminal in split
function M.new_terminal_split()
	local term_id = M.create_terminal({
		name = "Split Terminal",
		position = "bottom",
		height = 0.4,
	})
	M.open_terminal(term_id)
	return term_id
end

--- Create and open terminal in vsplit
function M.new_terminal_vsplit()
	local term_id = M.create_terminal({
		name = "VSplit Terminal",
		position = "right",
		width = 0.4,
	})
	M.open_terminal(term_id)
	return term_id
end

--- Create and open floating terminal
function M.new_terminal_float()
	local term_id = M.create_terminal({
		name = "Float Terminal",
		position = "float",
		height = 0.8,
		width = 0.8,
	})
	M.open_terminal(term_id)
	return term_id
end

-- ============================================================================
-- COMMANDS
-- ============================================================================

function M.setup_commands()
	-- Create new terminals
	vim.api.nvim_create_user_command("TermNew", function()
		M.new_terminal()
	end, { desc = "Create new terminal" })

	vim.api.nvim_create_user_command("TermNewTab", function()
		M.new_terminal_tab()
	end, { desc = "Create terminal in new tab" })

	vim.api.nvim_create_user_command("TermNewSplit", function()
		M.new_terminal_split()
	end, { desc = "Create terminal in horizontal split" })

	vim.api.nvim_create_user_command("TermNewVSplit", function()
		M.new_terminal_vsplit()
	end, { desc = "Create terminal in vertical split" })

	vim.api.nvim_create_user_command("TermNewFloat", function()
		M.new_terminal_float()
	end, { desc = "Create floating terminal" })

	-- Terminal management
	vim.api.nvim_create_user_command("TermPick", function()
		M.pick_terminal()
	end, { desc = "Pick and manage terminals" })

	vim.api.nvim_create_user_command("TermList", function()
		M.list_terminals()
	end, { desc = "List all terminals" })

	vim.api.nvim_create_user_command("TermToggle", function(opts)
		local term_id = tonumber(opts.args)
		if term_id then
			M.toggle_terminal(term_id)
		else
			vim.notify("Usage: :TermToggle <terminal_id>", vim.log.levels.ERROR)
		end
	end, { nargs = 1, desc = "Toggle terminal by ID" })

	vim.api.nvim_create_user_command("TermClose", function(opts)
		local term_id = tonumber(opts.args)
		if term_id then
			M.close_terminal(term_id)
		else
			vim.notify("Usage: :TermClose <terminal_id>", vim.log.levels.ERROR)
		end
	end, { nargs = 1, desc = "Close terminal by ID" })

	vim.api.nvim_create_user_command("TermDelete", function(opts)
		local term_id = tonumber(opts.args)
		if term_id then
			M.delete_terminal(term_id)
		else
			vim.notify("Usage: :TermDelete <terminal_id>", vim.log.levels.ERROR)
		end
	end, { nargs = 1, desc = "Delete terminal by ID" })
end

-- ============================================================================
-- KEYBINDINGS
-- ============================================================================

function M.setup_keymaps()
	local keymap = vim.keymap.set

	-- Terminal creation
	keymap("n", "<leader>tt", M.new_terminal, { desc = "New Terminal" })
	keymap("n", "<leader>tT", M.new_terminal_tab, { desc = "New Terminal (Tab)" })
	keymap("n", "<leader>ts", M.new_terminal_split, { desc = "New Terminal (Split)" })
	keymap("n", "<leader>tv", M.new_terminal_vsplit, { desc = "New Terminal (VSplit)" })
	keymap("n", "<leader>tf", M.new_terminal_float, { desc = "New Terminal (Float)" })

	-- Terminal management
	keymap("n", "<leader>tp", M.pick_terminal, { desc = "Pick Terminal" })
	keymap("n", "<leader>tl", M.list_terminals, { desc = "List Terminals" })

	-- Quick toggle for first 5 terminals
	for i = 1, 5 do
		keymap("n", "<leader>t" .. i, function()
			M.toggle_terminal(i)
		end, { desc = "Toggle Terminal " .. i })
	end

	-- Alternative: Use Alt+number for quick access
	for i = 1, 9 do
		keymap({ "n", "t" }, "<M-" .. i .. ">", function()
			M.toggle_terminal(i)
		end, { desc = "Toggle Terminal " .. i })
	end
end

-- ============================================================================
-- SETUP
-- ============================================================================

function M.setup(opts)
	opts = opts or {}

	-- Setup commands
	M.setup_commands()

	-- Setup keymaps if not disabled
	if opts.setup_keymaps ~= false then
		M.setup_keymaps()
	end

	-- Create preset terminals if enabled
	if opts.create_presets then
		M.create_presets()
	end

	-- Optional: Auto-create a default terminal
	if opts.auto_create_default ~= false then
		M.create_terminal({
			name = "Default Terminal",
			position = "bottom",
			height = 0.4,
		})
	end
end

-- Auto-setup with defaults
M.setup()

return M
