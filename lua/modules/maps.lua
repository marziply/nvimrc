local utils = require("modules.utils")
local silent = {
	silent = true,
}

local function map(kind, bind, cmd, opts)
	return vim.api.nvim_set_keymap(kind, bind, cmd, opts or {})
end

local function map_telescope(char, opt)
	local bind = "<c-t>" .. char
	local cmd = "<cmd>Telescope " .. opt .. "<cr>"

	nmap(bind, cmd)
end

function nmap(bind, cmd, opts)
	return map("n", bind, cmd, opts)
end

function vmap(bind, cmd, opts)
	return map("v", bind, cmd, opts)
end

function imap(bind, cmd, opts)
	return map("i", bind, cmd, opts)
end

function nmap_all(binds)
	for bind, cmd in pairs(binds) do
		nmap(bind, cmd)
	end
end

function nmap_with_all(binds)
	for bind, fn in pairs(binds) do
		nmap_with(bind, fn)
	end
end

function nmap_with(bind, fn)
	return vim.keymap.set("n", bind, fn)
end

function vmap_with(bind, fn)
	return vim.keymap.set("v", bind, fn)
end

-- ## General ##

-- Reset CMD output
nmap("<esc>", ":echo<cr>", silent)
-- Remap ctrl c to escape in norm/vis
map("", "<c-c>", "<esc>")
-- Remap ctrl c to escape in ins/cmd
imap("<c-c>", "<esc>")
-- Unbind default <c-f> binding
nmap("<c-f>", "<nop>")
-- Save buffer in normal mode
nmap("<c-s>", ":w<cr>", silent)
-- Save buffer in insert mode
imap("<c-s>", "<esc>:w<cr>")
-- Quit buffer
nmap("<c-q>", ":bd<cr>", silent)
-- Scroll up
nmap("<c-k>", "10<c-y>")
-- Scroll down
nmap("<c-j>", "10<c-e>")
-- Center buffer after previous jump
nmap("<c-o>", "<c-o>zz")
-- Center buffer after next jump
nmap("<c-i>", "<c-i>zz")
-- Insert two lines up
nmap("<c-m>o", "o<esc>o")
-- Insert two lines down
nmap("<c-m>O", "O<esc>O")
-- Restart LSP
nmap("<c-g>LR", "<cmd>LspRestart<cr>")
-- Show LSP info on buffer
nmap("<c-g>LI", "<cmd>LspInfo<cr>")
-- Sync Lazy
nmap("<c-g>S", "<cmd>Lazy sync<cr>")
-- Update packages via Lazy
nmap("<c-g>U", "<cmd>Lazy update<cr>")
-- Show Lazy UI
nmap("<c-g>I", "<cmd>Lazy show<cr>")
-- Open terminal window
nmap("<c-g>t", "<cmd>ToggleTerm<cr>")
-- Source the current file
nmap("<c-g>s", '<cmd>exec "source " . expand("%")<cr>')
-- Open quick fixes
nmap("<c-g>gc", "<cmd>GitConflictListQf<cr>")
-- Insert one line up
nmap("mo", "o<esc>")
-- Insert one line down
nmap("mO", "O<esc>")
-- Insert one character and return to normal mode
nmap("Y", "i_<esc>r")
-- Jump to next search result and center buffer
nmap("n", "nzz")
-- Jump to previous search result and center buffer
nmap("N", "Nzz")
-- Switch to left buffer and center buffer
nmap("H", "Hzz")
-- Switch to right buffer and center buffer
nmap("L", "Lzz")
-- Scroll to bottom of buffer and center buffer
nmap("G", "Gzz")
-- Jump to next search of word at cursor and center buffer
nmap("*", "*zz")
-- Select block forward
nmap("v[", "V$%o$")
-- Select block backward
nmap("v]", "$%V%o$")
-- Comment toggle block forward
nmap("gcs", "v[gc")
-- Comment toggle block backward
nmap("gcS", "v]gc")
-- Reload all plugins
-- nmap_with("<c-g>R", function()
--   local config = require("lazy.core.config")
--   local loader = require("lazy.core.loader")
--
--   for name, plugin in pairs(config.plugins) do
--     local ok = pcall(loader.reload, plugin)
--
--     if ok then
--       print("Reloaded " .. name)
--     end
--   end
--
--   print("All plugins reloaded")
-- end)

-- ## Utils ##

-- Open Spectre window
nmap_with("<c-g>R", function()
	local spectre = require("spectre")

	spectre.open()
end)
-- Dismiss notifications
nmap_with("<c-g>c", function()
	local notify = require("notify")

	notify.dismiss({
		pending = true,
		silent = true,
	})
end)

-- ## LSP ##

-- Open diagnostics window
nmap_with("<c-g>d", function()
	vim.diagnostic.open_float({
		severity = vim.diagnostic.severity.HINT,
	})
	vim.diagnostic.open_float({
		severity = vim.diagnostic.severity.WARN,
	})
end)
-- Jump to previous diagnostic hint
nmap_with("[D", function()
	vim.diagnostic.goto_prev({
		severity = vim.diagnostic.severity.HINT,
	})
end)
-- Jump to next diagnostic hint
nmap_with("]D", function()
	vim.diagnostic.goto_next({
		severity = vim.diagnostic.severity.HINT,
	})
end)
-- Jump to previous warning hint
nmap_with("[w", function()
	vim.diagnostic.goto_prev({
		severity = vim.diagnostic.severity.WARN,
	})
end)
-- Jump to next arning hint
nmap_with("]w", function()
	vim.diagnostic.goto_next({
		severity = vim.diagnostic.severity.WARN,
	})
end)
-- Toggle inlay hints
nmap_with("<c-g>i", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end)

-- ## Command line ##

map("c", "<c-a>", "<home>")
map("c", "<c-f>", "<right>")
map("c", "<c-b>", "<left>")
map("c", "<c-d>", "<del>")
map("c", "<a-b>", "<s-left>")
map("c", "<a-f>", "<s-right>")

-- ## Buffers ##

-- Switch to highlighted buffer
nmap("<c-b>", "<cmd>BufferPick<cr>")
-- Switch to previous/left buffer
nmap("<c-p>", "<cmd>BufferPrevious<cr>")
-- Switch to next/right buffer
nmap("<c-n>", "<cmd>BufferNext<cr>")
-- Shift current buffer to the left
nmap("<a-<>", "<cmd>BufferMovePrevious<cr>")
-- Shift current buffer to the right
nmap("<a->>", "<cmd>BufferMoveNext<cr>")
-- Quit all buffers
nmap("<c-g>q", ":bufdo bd!<cr>")
-- Close current buffer
nmap("Q", "<cmd>BufferClose!<cr>")

-- ## Telescope ##

-- Open file discovery window
map_telescope("p", "find_files")
-- Open live grep window
map_telescope("f", "live_grep")
-- Open command history window
map_telescope("c", "command_history")
-- Open search history window
map_telescope("s", "search_history")
-- Open spell suggest window
map_telescope("S", "spell_suggest")
-- Open manual pages discovery window
map_telescope("M", "man_pages")
-- Open marks window
map_telescope("m", "marks")
-- Open quick fixes
map_telescope("q", "quickfix")
-- Open active regsiters window
map_telescope("r", "registers")
-- Open undo window
map_telescope("u", "undo")
-- Open live grep window using the word at cursor as a search term
map_telescope("*", "grep_string")
-- Open buffer diagnostics discovery window
map_telescope("lD", "diagnostics bufnr=0")
-- Jump to symbol references at cursor
map_telescope("lr", "lsp_references")
-- Jump to symbol implementations at cursor
map_telescope("li", "lsp_implementations")
-- Jump to symbol definition at cursor
map_telescope("ld", "lsp_definitions")
-- Open git commits window
map_telescope("gc", "git_commits")
-- Open git branches window
map_telescope("gb", "git_branches")
-- Open git status window
map_telescope("gs", "git_status")
-- Open file browser in Neovim directory
nmap_with("<c-t>C", function()
	local telescope = require("telescope.builtin")

	telescope.find_files({
		cwd = string.format("%s/lua", vim.env.NVIM_DIR),
	})
end)

-- Rename symbol at cursor
nmap_with("<c-g>r", function()
	utils.exec_from("renamer", function(r)
		r.rename()
	end)
end)

-- Substitude word at cursor
-- nmap_with("<c-g>s", function()
-- 	local word = vim.fn.expand("<cword>")
--
-- 	utils.popup_substitute(word)
-- end)

-- Substitude current visual selection
vmap_with("<c-r>", function()
	vim.cmd([[normal! "vy"]])

	utils.popup_substitute(vim.fn.getreg("v"))
end)

return {
	nmap = nmap,
	vmap = vmap,
	imap = imap,
	nmap_all = nmap_all,
	nmap_with = nmap_with,
	nmap_with_all = nmap_with_all,
}
