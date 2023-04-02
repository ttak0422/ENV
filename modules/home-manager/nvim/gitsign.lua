require("gitsigns").setup({
  signcolumn = false,
  numhl = true,
  status_formatter = function(status)
    local added, changed, removed = status.added, status.changed, status.removed
    local status_txt = {}
    if added and added > 0 then
      table.insert(status_txt, " " .. added)
    end
    if changed and changed > 0 then
      table.insert(status_txt, " " .. changed)
    end
    if removed and removed > 0 then
      table.insert(status_txt, " " .. removed)
    end
    return table.concat(status_txt, " ")
  end,
})
