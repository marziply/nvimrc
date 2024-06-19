return function()
	local store = require("schemastore")

	return {
		settings = {
			yaml = {
				customTags = {
					"!reference sequence",
				},
				keyOrdering = false,
				proseWrap = "always",
				schemas = store.yaml.schemas({
					ignore = {
						"Deployer Recipe",
						"RKE Cluster Configuration YAML",
					},
					extra = {
						{
							url = "https://taskfile.dev/schema.json",
							name = "taskfile.yaml",
							fileMatch = "**/taskfile.yaml",
						},
					},
				}),
				schemaStore = {
					enable = false,
					url = "",
				},
			},
		},
	}
end
