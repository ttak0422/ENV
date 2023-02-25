-- require virtual-types-nvim, inlayHint, hover.nvim
return function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local diagnostic_wrn_opts = { severity = { min = vim.diagnostic.severity.WARN }, float = false }
  local diagnostic_err_opts = { severity = vim.diagnostic.severity.ERROR, float = false }
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev(diagnostic_wrn_opts)
  end, bufopts)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next(diagnostic_wrn_opts)
  end, bufopts)
  vim.keymap.set("n", "[D", function()
    vim.diagnostic.goto_prev(diagnostic_err_opts)
  end, bufopts)
  vim.keymap.set("n", "]D", function()
    vim.diagnostic.goto_next(diagnostic_err_opts)
  end, bufopts)

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gv", "<cmd>vsplit<cr>gd", bufopts)
  vim.keymap.set("n", "gs", "<cmd>split<cr>gd", bufopts)
  -- vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", bufopts)

  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  -- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
  -- vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
  -- vim.keymap.set('n', 'K', '<cmd>DocsViewToggle<CR>', bufopts)
  -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, bufopts)

  -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set("n", "<space>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)

  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)

  vim.keymap.set("n", "<space>ca", require("actions-preview").code_actions, bufopts)
  -- vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)

  -- if client.supports_method('textDocument/codeLens') then
  --   require('virtualtypes').on_attach(client, bufnr)
  -- end
  if client.supports_method("textDocument/inlayHint") then
    require("lsp-inlayhints").on_attach(client, bufnr, false)
  end
  if client.supports_method("textDocument/formatting") then
    vim.keymap.set("n", "<leader>F", "<cmd>Format<cr>", bufopts)
  end
  if client.supports_method("textDocument/publishDiagnostics") then
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      -- delay update diagnostics
      vim.lsp.diagnostic.on_publish_diagnostics,
      { update_in_insert = false }
    )
  end
end
