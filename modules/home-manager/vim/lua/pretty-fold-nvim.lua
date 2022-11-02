require("pretty-fold").setup({
  -- keep_indentation = false,
  --keep_indentation = true,
  fill_char = "•",
  sections = {
    left = {
      function()
        return string.rep(" ", vim.o.shiftwidth * vim.v.foldlevel)
      end,
      " ",
      "number_of_folded_lines",
      ": ",
      "content",
      " ",
    },
  },
})
-- require('fold-preview').setup {
--   default_keybindings = false;
-- }
