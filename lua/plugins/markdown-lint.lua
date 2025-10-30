local CONFIG_HOME = "/home/michael/.config/nvim/"
return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", CONFIG_HOME .. "lua/plugins/markdownlint-cli2.yaml", "--" },
      },
    },
  },
}
