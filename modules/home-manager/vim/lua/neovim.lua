return function(opt)
  local editor_config = opt.editor_config
  vim.opt.cmdheight = 1

  local nvrcmd = "nvr --remote-wait"
  vim.env.VISUAL = nvrcmd
  vim.env.GIT_EDITOR = nvrcmd

  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.opt.guifont = "PlemolJP35 Console NFJ"

  vim.api.nvim_create_augroup("extraConfig", {})
  vim.api.nvim_create_autocmd("BufNewFile", {
    group = "extraConfig",
    pattern = ".editorconfig",
    callback = function()
      vim.cmd("0r " .. editor_config)
    end,
  })
  vim.api.nvim_create_autocmd("FileType", {
    group = "extraConfig",
    pattern = { "gitcommit", "gitrebase", "gitconfig" },
    callback = function()
      vim.bo[0].bufhidden = "delete"
    end,
  })

  local opts = { noremap = true, silent = true }
  vim.keymap.set("n", "<C-h>", "<cmd>bprev<cr>", opts)
  vim.keymap.set("n", "<C-l>", "<cmd>bnext<cr>", opts)
  vim.keymap.set("n", "<C-q>", "<cmd>bd<cr>", opts)
  vim.keymap.set("n", "<esc><esc>", "<cmd>nohl<cr>", opts)
  vim.keymap.set("n", "j", "gj", opts)
  vim.keymap.set("n", "k", "gk", opts)
  vim.keymap.set("n", "q", "<nop>", opts)
  vim.keymap.set("n", "<C-g>", "<nop>", opts)
  vim.keymap.set("i", "<C-a>", "<home>", opts)
  vim.keymap.set("i", "<C-e>", "<end>", opts)
  vim.keymap.set("t", "<C-[>", "<C-\\><C-n>", opts)
end
