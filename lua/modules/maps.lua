local utils = require('modules.utils')

local function map(kind, bind, cmd, opts)
	return vim.api.nvim_set_keymap(kind, bind, cmd, opts or {})
end

local function map_telescope(char, opt)
  local bind = '<c-f>' .. char
  local cmd = '<cmd>Telescope ' .. opt .. '<cr>'

  nmap(bind, cmd)
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
nmap('<esc>', ':echo<cr>', {
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

-- LSP
nmap_with('<c-g>d', function() vim.diagnostic.open_float() end)
nmap_with('[d', function() vim.diagnostic.goto_prev() end)
nmap_with(']d', function() vim.diagnostic.goto_next() end)

-- Barbar / buffers
nmap('<c-b>', '<cmd>BufferPick<cr>')
nmap('<c-n>', '<cmd>BufferNext<cr>')
nmap('<c-p>', '<cmd>BufferPrevious<cr>')
nmap('<a->>', '<cmd>BufferMoveNext<cr>')
nmap('<a-<>', '<cmd>BufferMovePrevious<cr>')
nmap('<c-g>q', ':bufdo bd<cr>')
nmap('Q', '<cmd>BufferClose<cr>')

-- Telescope
map_telescope('p', 'find_files')
map_telescope('f', 'live_grep theme=dropdown')
map_telescope('h', 'command_history theme=dropdown')
map_telescope('s', 'search_history theme=dropdown')
map_telescope('c', 'spell_suggest theme=get_cursor')
map_telescope('m', 'man_pages')
map_telescope('r', 'registers theme=dropdown')
map_telescope('*', 'grep_string')
map_telescope('lD', 'diagnostics')
map_telescope('ld', 'diagnostics bufnr=0')
map_telescope('lr', 'lsp_references')
map_telescope('li', 'lsp_implementations')
map_telescope('lt', 'lsp_definitions')
map_telescope('gc', 'git_commits')
map_telescope('gb', 'git_branches')
map_telescope('gs', 'git_status')

-- ToggleTerm
nmap('<c-g>t', '<cmd>ToggleTerm<cr>')

-- Renamer
nmap_with('<c-g>r', function()
  utils.exec_from('renamer', function(r) r.rename() end)
end)

return {
	nmap = nmap,
	vmap = vmap,
	imap = imap,
	nmap_with = nmap_with
}
