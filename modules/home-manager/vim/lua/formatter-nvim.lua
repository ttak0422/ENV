local util = require("formatter.util")

require("formatter").setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    lua = {
      require("formatter.filetypes.lua").stylua,
    },
    java = {
      function()
        return {
          exe = "google-java-format",
          args = {
            "-",
          },
          stdin = true,
        }
      end,
    },
    nix = {
      function()
        return {
          exe = "nixfmt",
          stdin = true,
        }
      end,
    },
    dart = {
      require("formatter.filetypes.dart").dartformat,
    },
  },
})
