use {
  'ray-x/lsp_signature.nvim',
  config = function()
    require 'lsp_signature'.setup({
      bind = true,
      handler_opts = {
        border = 'rounded'
      }
    })
  end,
}
