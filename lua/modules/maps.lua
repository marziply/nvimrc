function nmap(bind, cmd, opts)
	return vim.keymap.set("n", bind, cmd, opts)
end

function vmap(bind, cmd, opts)
	return vim.keymap.set("v", bind, cmd, opts)
end

function imap(bind, cmd, opts)
	return vim.keymap.set("i", bind, cmd, opts)
end

function cmap(bind, cmd, opts)
	return vim.keymap.set("c", bind, cmd, opts)
end

function lmap(bind, cmd, opts)
	return nmap("<leader>" .. bind, cmd, opts)
end

function slmap(bind, cmd, opts)
	opts = opts or {}

	opts.silent = true

	return lmap(bind, cmd, opts)
end

function snmap(bind, cmd, opts)
	opts = opts or {}

	opts.silent = true

	return nmap(bind, cmd, opts)
end

function nmap_all(binds)
	for bind, fn in pairs(binds) do
		nmap(bind, fn)
	end
end

function move_tab(cmd)
	local plug = string.format("<plug>(Repeat%s)", cmd)
	local exec = string.format('call repeat#set("\\%s")', plug)

	snmap(plug, function()
		vim.cmd(cmd)
	end)

	return function()
		vim.cmd(cmd)
		vim.cmd(exec)
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

-- Remap ctrl c to escape in norm/vis
vim.keymap.set({ "n", "v" }, "<c-c>", "<esc>")
-- Reset CMD output
snmap("<esc>", ":echo<cr>")
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
nmap("<c-k>", "15<c-y>")
-- Scroll down
nmap("<c-j>", "15<c-e>")
-- Previous jump and center
nmap("<c-o>", "<c-o>zz")
-- Next jump and center
nmap("<c-i>", "<c-i>zz")
-- Insert two lines up
lmap("iu", "O<esc>O")
-- Insert two lines down
lmap("id", "o<esc>o")
-- Jump to next search result and center buffer
nmap("n", "nzz")
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
-- Execute last command
slmap("<leader>", ":<c-p><cr>")
-- Reset LSP
slmap("dr", function()
	vim.diagnostic.reset(nil, vim.api.nvim_get_current_buf())

	vim.print("Reset LSP")
end)

-- ## LSP ##

-- Go to definition
nmap("gd", vim.lsp.buf.definition)
-- Jump to previous warning hint
nmap("[w", jump_to_warning(-1))
-- Jump to next arning hint
nmap("]w", jump_to_warning(1))
-- Toggle inlay hints
lmap("ii", function()
	local enabled = vim.lsp.inlay_hint.is_enabled()

	vim.lsp.inlay_hint.enable(not enabled)
end)
-- Open diagnostics window
lmap("d", function()
	vim.diagnostic.open_float({
		severity = vim.diagnostic.severity.HINT,
	})
	vim.diagnostic.open_float({
		severity = vim.diagnostic.severity.WARN,
	})
end)
slmap("RR", function()
	vim.lsp.stop_client(vim.lsp.get_clients())

	vim.cmd([[bufdo! edit]])
end)

-- ## Buffers ##

-- Close all buffers
slmap("bd", ":bufdo bd!<cr>")
-- Close all buffers except current
slmap("be", ":%bd | e# | bd#<cr>")
-- Close current buffer
snmap("Q", ":bp | bd#<cr>")
-- Switch to highlighted buffer
nmap("<c-b>", "<cmd>BufferLinePick<cr>")
-- Switch to previous/left buffer
nmap("<c-p>", "<cmd>BufferLineCyclePrev<cr>")
-- Switch to next/right buffer
nmap("<c-n>", "<cmd>BufferLineCycleNext<cr>")
-- Shift current buffer to the left
lmap("<", move_tab("BufferLineMovePrev"))
-- Shift current buffer to the right
lmap(">", move_tab("BufferLineMoveNext"))

-- ## Plugins ##

-- Open Spectre window
lmap("rr", function()
	local spectre = require("spectre")

	spectre.open()
end)

return {
	nmap = nmap,
	vmap = vmap,
	imap = imap,
	nmap_all = nmap_all,
}
