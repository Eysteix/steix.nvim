local function start_sass_watcher()
	local file = vim.fn.expand("%")
	local css = vim.fn.expand("%:r") .. ".css"

	-- Check if watcher already running for this file
	local existing = vim.fn.system("pgrep -fl 'sass --watch --no-source-map " .. file .. "'")

	if existing == "" then
		vim.fn.jobstart({ "sass", "--watch", "--no-source-map", file .. ":" .. css }, { detach = true })
		print("Started SASS watcher for " .. file)
	else
		-- Optional: notify watcher already exists
		-- print("SASS watcher already running for " .. file)
	end
end

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.scss",
	callback = start_sass_watcher,
})
