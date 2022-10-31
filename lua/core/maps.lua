local function map(kind, bind, cmd, opts)
	return vim.api.nvim_set_keymap(kind, bind, cmd, opts or {})
end

function nmap(bind, cmd, opts)
	return map('n', bind, cmd, opts)
end

function vmap(bind, cmd, opts)
	return map('v', bind, cmd, opts)
end

function imap(bind, cmd, opts)
	return map('i', bind, cmd, opts)
end

function nmap_with(bind, fn)
	return vim.keymap.set('n', bind, fn)
end

-- General
nmap('<esc>', ':noh<cr>', {
	silent = true
})
nmap('<c-s>', ':w<cr>')
nmap('H', 'Hzz')
nmap('L', 'Lzz')

-- Barbar
nmap('<c-b>', '<cmd>BufferPick<cr>')
nmap('<c-n>', '<cmd>BufferNext<cr>')
nmap('<c-p>', '<cmd>BufferPrevious<cr>')
nmap('<a->>', '<cmd>BufferMoveNext<cr>')
nmap('<a-<>', '<cmd>BufferMovePrevious<cr>')
nmap('Q', '<cmd>BufferClose<cr>')

-- Telescope
nmap('<c-f>p', '<cmd>Telescope find_files<cr>')
nmap('<c-f>f', '<cmd>Telescope live_grep<cr>')

return {
	nmap = nmap,
	vmap = vmap,
	imap = imap,
	nmap_with = nmap_with
}
