local saga = require("lspsaga")

saga.init_lsp_saga({
  -- border_style = "none",
  symbol_in_winbar = {
    in_custom = true,
    enable = true,
    show_file = true,
    click_support = false,
  },
  show_outline = {
    win_position = "right",
    win_width = 35,
    auto_enter = true,
    auto_preview = true,
    virt_text = "┃",
    jump_key = "o",
    auto_refresh = true,
  },
  code_action_lightbulb = {
    enable = false,
    enable_in_insert = false,
    cache_code_action = true,
    sign = true,
    update_time = 300,
    virtual_text = false,
  },
  finder_request_timeout = 30000,
  finder_action_keys = {
    open = "o",
    vsplit = "v",
    split = "s",
    tabe = "t",
    quit = "q",
  },
})
local function get_file_name(include_path)
  local file_name = require("lspsaga.symbolwinbar").get_file_name()
  if vim.fn.bufname("%") == "" then
    return ""
  end
  if include_path == false then
    return file_name
  end
  local sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
  local path_list = vim.split(string.gsub(vim.fn.expand("%:~:.:h"), "%%", ""), sep)
  local file_path = " "
  for _, cur in ipairs(path_list) do
    file_path = (cur == "." or cur == "~") and "" or file_path .. cur .. " " .. "%#LspSagaWinbarSep#%*" .. " %*"
  end
  return file_path .. file_name
end

local function config_winbar()
  local exclude = {
    ["terminal"] = true,
    ["toggleterm"] = true,
    ["prompt"] = true,
    ["NvimTree"] = true,
    ["SidebarNvim"] = true,
    ["help"] = true,
  }
  if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
    vim.wo.winbar = ""
  else
    vim.wo.winbar = get_file_name(true)
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    config_winbar()
  end,
})