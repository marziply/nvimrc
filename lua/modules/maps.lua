function map(kind, bind, cmd, opts)
	if type(cmd) == "function" then
		return vim.keymap.set(kind, bind, cmd, opts or {})
	end

	return vim.api.nvim_set_keymap(kind, bind, cmd, opts or {})
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

function cmap(bind, cmd, opts)
	return map("c", bind, cmd, opts)
end

function lmap(bind, cmd, opts)
	return nmap("<leader>" .. bind, cmd, opts)
end

function snmap(bind, cmd, opts)
	local _opts = opts or {}

	_opts.silent = true

	return nmap(bind, cmd, _opts)
end

function nmap_all(binds)
	for bind, fn in pairs(binds) do
		nmap(bind, fn)
	end
end

function tmap(bind, opt)
	local cmd = "<cmd>Telescope " .. opt .. "<cr>"

	lmap(bind, cmd)
end

function browse_config(dir)
	return function()
		local telescope = require("telescope.builtin")

		telescope.find_files({
			cwd = string.format("%s/%s", vim.env.NVIM_DIR, dir),
		})
	end
end

function jump_to_diagnostic(index, severity)
	return function()
		vim.diagnostic.jump({
			count = index,
			severity = severity,
			float = true,
		})
	end
end

function jump_to_error(index)
	return jump_to_diagnostic(index, vim.diagnostic.severity.ERROR)
end

function jump_to_warning(index)
	return jump_to_diagnostic(index, vim.diagnostic.severity.WARN)
end

-- ## General ##

-- Reset CMD output
snmap("<esc>", ":echo<cr>")
-- Remap ctrl c to escape in norm/vis
map("", "<c-c>", "<esc>")
-- Remap ctrl c to escape in ins/cmd
imap("<c-c>", "<esc>")
-- Unbind default <c-f> binding
nmap("<c-f>", "<nop>")
-- Save buffer in normal mode
snmap("<c-s>", ":w<cr>")
-- Save buffer in insert mode
imap("<c-s>", "<esc>:w<cr>")
-- Quit buffer
snmap("<c-q>", ":bd<cr>")
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
-- Open list of Git conflicts
lmap("gq", "<cmd>GitConflictListQf<cr>")
-- Insert one line up
nmap("mo", "o<esc>")
-- Insert one line down
nmap("mO", "O<esc>")
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

-- ## Utils ##

-- Open Spectre window
lmap("rr", function()
	local spectre = require("spectre")

	spectre.open()
end)

-- ## LSP ##

-- Open diagnostics window
lmap("d", function()
	vim.diagnostic.open_float({
		severity = vim.diagnostic.severity.HINT,
	})
	vim.diagnostic.open_float({
		severity = vim.diagnostic.severity.WARN,
	})
end)
-- Jump to previous diagnostic hint
nmap("[D", jump_to_error(-1))
-- Jump to next diagnostic hint
nmap("]D", jump_to_error(1))
-- Jump to previous warning hint
nmap("[w", jump_to_warning(-1))
-- Jump to next arning hint
nmap("]w", jump_to_warning(1))
-- Toggle inlay hints
lmap("i", function()
	local enabled = vim.lsp.inlay_hint.is_enabled()

	vim.lsp.inlay_hint.enable(not enabled)
end)
-- Go to definition
nmap("gd", function()
	vim.lsp.buf.definition()
end)

-- ## Command line ##

cmap("<c-a>", "<home>")
cmap("<c-f>", "<right>")
cmap("<c-b>", "<left>")
cmap("<c-d>", "<del>")
cmap("<a-b>", "<s-left>")
cmap("<a-f>", "<s-right>")

-- ## Buffers ##

-- Switch to highlighted buffer
nmap("<c-b>", "<cmd>BufferLinePick<cr>")
-- Switch to previous/left buffer
nmap("<c-p>", "<cmd>BufferLineCyclePrev<cr>")
-- Switch to next/right buffer
nmap("<c-n>", "<cmd>BufferLineCycleNext<cr>")
-- Shift current buffer to the left
lmap("<", "<cmd>BufferLineMovePrev<cr>")
-- Shift current buffer to the right
lmap(">", "<cmd>BufferLineMoveNext<cr>")
-- Quit all buffers
lmap("q", ":bufdo bd!<cr>")
-- Close current buffer
nmap("Q", ":bp | bd#<cr>")

-- ## Telescope ##

-- Open quick fixes
tmap("q", "quickfix")
-- Open undo window
tmap("u", "undo")
-- Open live grep window for word at cursor
tmap("*", "grep_string")
-- Open file discovery window
tmap("ff", "find_files")
-- Open live grep window
tmap("fg", "live_grep")
-- Open command history window
tmap("ch", "command_history")
-- Open search history window
tmap("sh", "search_history")
-- Open spell suggest window
tmap("ss", "spell_suggest")
-- Open manual pages discovery window
tmap("mp", "man_pages")
-- Open marks window
tmap("ma", "marks")
-- Open active regsiters window
tmap("re", "registers")
-- Open buffer diagnostics discovery window
tmap("lo", "diagnostics bufnr=0")
-- Jump to symbol references at cursor
tmap("lr", "lsp_references")
-- Jump to symbol implementations at cursor
tmap("li", "lsp_implementations")
-- Jump to symbol definition at cursor
tmap("ld", "lsp_definitions")
-- Open git commits window
tmap("gc", "git_commits")
-- Open git branches window
tmap("gb", "git_branches")
-- Open git status window
tmap("gs", "git_status")
-- Open file browser in Neovim lua directory
lmap("nl", browse_config("lua"))
-- Open file browser in Neovim config directory
lmap("nc", browse_config("config"))

return {
	nmap = nmap,
	vmap = vmap,
	imap = imap,
	nmap_all = nmap_all,
}
