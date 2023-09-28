return {
	{
		"simrat39/rust-tools.nvim",
		config = true,
		opts = {
			-- tools = {
			-- 	inlay_hints = {
			-- 		highlight = "NoText"
			-- 	}
			-- }
			-- server = {
			-- 	settings = {
			-- 		["rust-analyzer"] = {
			-- 			rustfmt = {
			-- 				extraArgs = {
			-- 					"+nightly"
			-- 				}
			-- 			}
			-- 		}
			-- 	},
			-- 	["rust-analyzer"] = {
			-- 		rustfmt = {
			-- 			extraArgs = {
			-- 				"+nightly"
			-- 			}
			-- 		}
			-- 	}
			-- }
		},
		dependencies = {
			"saecki/crates.nvim",
			config = true
		}
	}
}
