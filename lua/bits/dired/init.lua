local config = require("bits.dired.config")

local M = {}
function M.setup(opts)
	-- apply user config
	local errs = config.update(opts)
	require("bits.dired.highlight").setup()
	if #errs == 1 then
		vim.api.nvim_err_writeln("(dired.setup, 1) failed to apply user config: " .. errs[1])
	elseif #errs > 1 then
		vim.api.nvim_err_writeln("(dired.setup, 2) failed to apply user config:")
		for _, err in ipairs(errs) do
			vim.api.nvim_err_writeln("    " .. err)
		end
	end

	-- if dired has already been loaded then just ignore the setup function
	if vim.g.dired_loaded then
		return
	end

	require("bits.dired.setup.globals").setup()
	require("bits.dired.setup.cmd").setup()
	require("bits.dired.setup.keybinds").setup()

	-- automatically open dired upon various events such as netrw, split, tabedit etc
	local dired_group = vim.api.nvim_create_augroup("dired", { clear = true })
	-- vim.api.nvim_create_autocmd("BufEnter", {
	-- 	pattern = "*",
	-- 	command = "if isdirectory(expand('%')) && !&modified | execute 'lua require(\"bits.dired.dired\").init_dired()' | endif",
	-- 	group = dired_group,
	-- })
	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = "*",
		command = "if exists('#FileExplorer') | execute 'autocmd! FileExplorer *' | endif",
		group = dired_group,
	})
	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = "*",
		command = "if exists('#NERDTreeHijackNetrw') | exe 'au! NERDTreeHijackNetrw *' | endif",
		group = dired_group,
	})
	vim.cmd([[if exists('#FileExplorer') | execute 'autocmd! FileExplorer *' | endif]])

	-- indicate that dired has been loaded
	vim.g.dired_loaded = true
end
return M
