local function get_execs()
	local results = {}
	local dir = vim.fn.getcwd() .. "/target/debug"
	local handle = vim.loop.fs_scandir(dir)

	if not handle then
		return results
	end

	while true do
		local name, type = vim.loop.fs_scandir_next(handle)

		if not name then
			break
		end

		if type == "file" then
			local full = dir .. "/" .. name

			if vim.fn.executable(full) == 1 then
				table.insert(results, full)
			end
		end
	end

	return results
end

local function pick_exec()
	return coroutine.create(function(co)
		local binaries = get_execs()

		if #binaries == 0 then
			error("No executables in ./target/debug")
		end

		Snacks.picker({
			title = "Select Rust binary",
			layout = {
				preset = "select",
			},
			items = vim.tbl_map(function(path)
				return {
					label = vim.fn.fnamemodify(path, ":t"),
					value = path,
				}
			end, binaries),

			confirm = function(ctx, item)
				ctx:close()
				coroutine.resume(co, item.value)
			end,

			cancel = function()
				coroutine.resume(co, nil)
			end,
		})
	end)
end

return {
	{
		"mfussenegger/nvim-dap",
		init = function()
			local dap = require("dap")

			-- dap.adapters.rust = {
			-- 	type = "executable",
			-- 	command = "rust-gdb",
			-- 	args = {
			-- 		"--interpreter=dap",
			-- 		"--eval-command",
			-- 		"set print pretty on",
			-- 	},
			-- }
			dap.adapters.rust = {
				type = "executable",
				command = "codelldb",
			}

			dap.configurations.rust = {
				{
					name = "launch",
					type = "rust",
					request = "launch",
					program = pick_exec,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = false,
				},
			}
		end,
	},
	{
		"igorlfs/nvim-dap-view",
		lazy = false,
		opts = {},
	},
}
