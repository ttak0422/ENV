local util = require("formatter.util")
local lspconfig = require("lspconfig")
require("formatter").setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    html = {
      require("formatter.filetypes.html").tidy,
    },
    json = {
      require("formatter.filetypes.json").fixjson,
    },
    toml = {
      require("formatter.filetypes.toml").taplo,
    },
    sh = {
      require("formatter.filetypes.sh").shfmt,
    },
    lua = {
      require("formatter.filetypes.lua").stylua,
    },
    python = {
      require("formatter.filetypes.python").yapf,
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
    go = {
      require("formatter.filetypes.go").gofmt,
    },
    rust = {
      require("formatter.filetypes.rust").rustfmt,
    },
    typescript = {
      function()
        local node_root_dir = lspconfig.util.root_pattern("package.json")
        local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil
        if is_node_repo then
          return require("formatter.filetypes.typescript").prettier()
        end
        return require("formatter.filetypes.typescript").denofmt()
      end,
    },
  },
})
