local keymaps = {}
local commands = {
  { ":UpdateRemotePlugins", description = "[REQUIRE] every time a remote plugin is installed, updated, or deleted" },
}
local functions = {}
local autocmds = {}
require("legendary").setup({
  include_builtin = false,
  include_legendary_cmds = false,
  col_separator_char = "",
  keymaps = keymaps,
  commands = commands,
  functions = functions,
  autocmds = autocmds,
})
