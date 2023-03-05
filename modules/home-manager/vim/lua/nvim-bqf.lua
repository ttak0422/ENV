local fn = vim.fn

function _G.qftf(info)
  local items
  local ret = {}

  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local fname_limit = 30
  local fname_path_limit = 70
  local fname_fmt_1, fname_fmt_2 = "%-" .. fname_limit .. "s", "…%." .. (fname_limit - 1) .. "s"
  local fmt = "%s │ %s" -- fname_path │ text
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local line
    local fname = ""
    local path = ""
    if e.valid == 1 then
      if e.bufnr > 0 then
        local bufname = fn.bufname(e.bufnr)
        if bufname == "" then
          fname = "[No Name]"
          path = "([buf])"
        else
          fname = fn.fnamemodify(bufname, ":t")
          path = fn.fnamemodify(bufname, ":h"):gsub("^" .. vim.env.HOME, "~")
        end

        local path_limit = 0
        -- format fname
        if #fname <= fname_limit then
          fname = fname
          path_limit = fname_path_limit - #fname
        else
          fname = fname_fmt_2:format(fname:sub(1 - fname_limit))
          path_limit = fname_path_limit - #fname + 2
        end

        -- format path
        if #path <= path_limit then
          path = string.format("%" .. path_limit .. "s", path)
        else
          path = string.format("…%." .. (path_limit - 1) .. "s", path:sub(1 - path_limit))
        end
      end
      line = fmt:format(fname .. "    " .. path, e.text)
    else
      line = e.text
    end
    table.insert(ret, line)
  end
  return ret
end

vim.o.qftf = "{info -> v:lua._G.qftf(info)}"
