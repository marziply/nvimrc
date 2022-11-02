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
nmap('<c-q>', ':bd<cr>')
nmap('<c-k>', '10<c-y>')
nmap('<c-j>', '10<c-e>')
nmap('<c-o>', '<c-o>zz')
nmap('<c-i>', '<c-i>zz')
nmap('*', '*zz')
nmap('n', 'nzz')
nmap('N', 'Nzz')
nmap('H', 'Hzz')
nmap('L', 'Lzz')
nmap('G', 'Gzz')
nmap('mo', 'o<esc>')
nmap('mO', 'O<esc>')
nmap('<c-m>o', 'o<esc>o')
nmap('<c-m>O', 'O<esc>O')

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

-- Renamer
nmap_with('<c-f>r', function()
	local renamer = require('renamer')

	renamer.rename()
end)

return {
	nmap = nmap,
	vmap = vmap,
	imap = imap,
	nmap_with = nmap_with
}
