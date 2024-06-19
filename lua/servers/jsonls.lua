return function()
	local store = require("schemastore")

	return {
		settings = {
			json = {
				schemas = store.json.schemas(),
				validate = {
					enable = true,
				},
			},
		},
	}
end
