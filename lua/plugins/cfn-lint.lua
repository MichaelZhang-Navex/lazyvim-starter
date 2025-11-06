return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              schemas = require("schemastore").yaml.schemas(),
              -- Add custom tags for AWS intrinsic functions to prevent false positives
              customTags = {
                "!Ref scalar",
                "!GetAtt scalar",
                "!Sub scalar",
                "!Join sequence",
                "!ImportValue scalar",
                "!Base64 scalar",
                "!Cidr sequence",
                "!And sequence",
                "!Equals sequence",
                "!If sequence",
                "!Not sequence",
                "!Or sequence",
                "!FindInMap sequence",
              },
            },
          },
        },
      },
    },
  },
  -- Ensure schemastore.nvim is installed and configured
  "b0o/schemastore.nvim",
}
