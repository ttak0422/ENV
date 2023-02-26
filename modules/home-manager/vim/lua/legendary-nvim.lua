local keymaps = {}
local commands = {
  { ":UpdateRemotePlugins", description = "[REQUIRE] every time a remote plugin is installed, updated, or deleted" },
  { ":write | edit | TSBufEnable highlight", description = "reload file" },
  { ":so $VIMRUNTIME/syntax/hitest.vim", description = "enumerate highlight" },
  { ":Fontzoom +1", description = "increment guifont size" },
  { ":Fontzoom -1", description = "decrement guifont size" },
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
