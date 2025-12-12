local dired = require("bits.dired.dired")
local config = require("bits.dired.config")

local M = {}
M.setup = function()
	local map = vim.api.nvim_buf_set_keymap
	-- check if `-` has been mapped to something or something has been mapped to `:DiredGoBack<CR>`
	-- if both conditions are okay, then map that keybind
	if vim.fn.mapcheck("-", "n") == "" and not vim.fn.hasmapto(":DiredGoBack<CR>", "n") then
		map("n", "-", ":DiredGoBack<CR>", { silent = true })
	end

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "dired",
		callback = function()
			local opt = { silent = true, noremap = true }

			map(0, "n", config.get("keybinds").dired_enter, ":DiredEnter<CR>", opt)
			map(0, "n", config.get("keybinds").dired_back, ":DiredGoBack<CR>", opt)
			map(0, "n", config.get("keybinds").dired_up, ":DiredGoUp<CR>", opt)
			map(0, "n", config.get("keybinds").dired_rename, ":DiredRename<CR>", opt)
			map(0, "n", config.get("keybinds").dired_create, ":DiredCreate<CR>", opt)
			map(0, "n", config.get("keybinds").dired_delete, ":DiredDelete<CR>", opt)
			map(0, "v", config.get("keybinds").dired_delete_range, ":<C-u>DiredDeleteRange<CR>", opt)
			map(0, "n", config.get("keybinds").dired_duplicate, ":DiredDuplicate<CR>", opt)
			map(0, "n", config.get("keybinds").dired_copy, ":DiredCopy<CR>", opt)
			map(0, "v", config.get("keybinds").dired_copy_range, ":<C-u>DiredCopyRange<CR>", opt)
			map(0, "n", config.get("keybinds").dired_copy_marked, ":DiredCopyMarked<CR>", opt)
			map(0, "n", config.get("keybinds").dired_move, ":DiredMove<CR>", opt)
			map(0, "v", config.get("keybinds").dired_move_range, ":<C-u>DiredMoveRange<CR>", opt)
			map(0, "n", config.get("keybinds").dired_move_marked, ":DiredMoveMarked<CR>", opt)
			map(0, "n", config.get("keybinds").dired_paste, ":DiredPaste<CR>", opt)
			map(0, "n", config.get("keybinds").dired_mark, ":DiredMark<CR>", opt)
			map(0, "v", config.get("keybinds").dired_mark_range, ":<C-u>DiredMarkRange<CR>", opt)
			map(0, "n", config.get("keybinds").dired_delete_marked, ":DiredDeleteMarked<CR>", opt)
			map(0, "n", config.get("keybinds").dired_shell_cmd, ":DiredShellCmd<CR>", opt)
			map(0, "n", config.get("keybinds").dired_shell_cmd_curr_path, ":DiredShellCmdCurrPath<CR>", opt)
			map(0, "n", config.get("keybinds").dired_shell_cmd_marked, ":DiredShellCmdMarked<CR>", opt)
			map(0, "n", config.get("keybinds").dired_toggle_hidden, ":DiredToggleHidden<CR>", opt)
			map(0, "n", config.get("keybinds").dired_toggle_sort_order, ":DiredToggleSortOrder<CR>", opt)
			map(0, "n", config.get("keybinds").dired_toggle_colors, ":DiredToggleColors<CR>", opt)
			map(0, "n", config.get("keybinds").dired_toggle_icons, ":DiredToggleIcons<CR>", opt)
			map(0, "n", config.get("keybinds").dired_toggle_hide_details, ":DiredToggleHideDetails<CR>", opt)
			map(0, "n", config.get("keybinds").dired_quit, ":DiredQuit<CR>", opt)

			-- config based keybinds
			if config.get("enable_click_preview") then
				vim.keymap.set("n", "<LeftMouse>", function()
					dired.preview_highlight_current_line()
				end, { buffer = 0, silent = true, noremap = true })
			end
			if config.get("enable_double_click_open") then
				map(0, "n", "<2-LeftMouse>", "<LeftMouse>:DiredEnter<CR>", opt)
			end
		end,
	})
end
return M
