local lint = require("lint")

local local_config = vim.g.checkstyle_config_file
if local_config ~= nil then
  lint.linters.checkstyle.config_file = local_config
else
  lint.linters.checkstyle.config_file = args.checkstyle_config_file_path
end

lint.linters_by_ft = {
  java = { "checkstyle" },
  nix = { "statix" },
  lua = { "luacheck" },
  python = { "flake8" },
  html = { "tidy" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
