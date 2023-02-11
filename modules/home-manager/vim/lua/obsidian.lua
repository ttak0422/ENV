require("obsidian").setup({
  dir = "~/vault",
  notes_subdir = "notes",
  daily_notes = {
    folder = "dailies",
  },
  completion = {
    nvim_cmp = false,
  },
  -- https://github.com/epwalsh/obsidian.nvim/blob/main/README.md
  note_id_func = function(title)
    local suffix = ""
    if title ~= nil then
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.time()) .. "-" .. suffix
  end,
})
