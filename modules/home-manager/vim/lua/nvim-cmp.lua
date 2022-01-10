vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require"cmp"
local lspkind = require('lspkind')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = false,
      maxwidth = 50,
      before = function (entry, vim_item)
        return vim_item
      end
    })
  }
})

