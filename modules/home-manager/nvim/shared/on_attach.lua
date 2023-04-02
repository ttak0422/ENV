-- require hover, lsp-inlayhints, actions-preview
return function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local diagnostic_wrn_opts = { severity = { min = vim.diagnostic.severity.WARN }, float = false }
  local diagnostic_err_opts = { severity = vim.diagnostic.severity.ERROR, float = false }

  -- motion
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

  -- jump
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

  -- action
  vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
  vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", require("actions-preview").code_actions, bufopts)
  -- WIP f/F motion
  -- if client.supports_method("textDocument/formatting") then
  --   vim.keymap.set("n", "<leader>F", "<cmd>Format<cr>", bufopts)
  -- end

  -- info
  if client.supports_method("textDocument/inlayHint") then
    require("lsp-inlayhints").on_attach(client, bufnr, false)
  end
  if client.supports_method("textDocument/publishDiagnostics") then
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      -- delay update diagnostics
      vim.lsp.diagnostic.on_publish_diagnostics,
      { update_in_insert = false }
    )
  end
end
