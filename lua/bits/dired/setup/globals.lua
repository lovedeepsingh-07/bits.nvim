local config = require("bits.dired.config")

local M = {}
M.setup = function()
	if config.get("show_colors") == nil then
		-- default for show-hidden is true
		vim.g.dired_show_colors = true
	else
		vim.g.dired_show_colors = config.get("show_colors")
	end

	-- global variable for show_hidden
	if config.get("show_hidden") == nil then
		-- default for show-hidden is true
		vim.g.dired_show_hidden = true
	else
		vim.g.dired_show_hidden = config.get("show_hidden")
	end

	-- global variable for show_icons
	if config.get("show_icons") == nil then
		-- default for show_icons is false
		vim.g.dired_show_icons = false
	else
		vim.g.dired_show_icons = config.get("show_icons")
	end

	-- global variable for hide_details
	if config.get("hide_details") == nil then
		-- default for show-hidden is true
		vim.g.dired_hide_details = true
	else
		vim.g.dired_hide_details = config.get("hide_details")
	end

	if config.get("show_dot_dirs") == nil then
		-- default for show-hidden is true
		vim.g.dired_show_dot_dirs = true
	else
		vim.g.dired_show_dot_dirs = config.get("show_dot_dirs")
	end

	-- global variable for sort_order
	if config.get("sort_order") == nil then
		-- default for sort_order is sort_by_name
		vim.g.dired_sort_order = true
	else
		vim.g.dired_sort_order = config.get("sort_order")
	end
end
return M
