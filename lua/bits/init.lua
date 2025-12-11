local M = {}

-- NOTE: this function runs a command in the same folder as the current file
local function curr_file_dir_cmd()
	local input = vim.fn.input("command: ")
	local curr_path = vim.fn.expand("%:p:h")
	print("command input: " .. input)
	print("curr_path : " .. curr_path)
end

function M.setup()
	vim.keymap.set("n", "\\!", curr_file_dir_cmd, {})
end

return M
