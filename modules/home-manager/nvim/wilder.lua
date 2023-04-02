local wilder = require("wilder")
wilder.setup({ modes = { ":", "/", "?" } })

wilder.set_option("pipeline", {
  wilder.branch(
    wilder.cmdline_pipeline({
      language = "python",
      fuzzy = 1,
    }),
    wilder.python_file_finder_pipeline({
      file_command = { "fd", "-tf" },
      dir_command = { "fd", "-td" },
      filters = { "fuzzy_filter", "difflib_sorter" },
    }),
    wilder.python_search_pipeline({
      pattern = wilder.python_fuzzy_pattern(),
      sorter = wilder.python_difflib_sorter(),
      engine = "re",
    })
  ),
})

wilder.set_option(
  "renderer",
  wilder.wildmenu_renderer({
    highlighter = wilder.lua_fzy_highlighter(),
    highlights = {
      accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#ec5f67" } }),
    },
  })
)
