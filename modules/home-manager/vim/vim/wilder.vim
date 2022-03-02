function! s:wilder_init() abort
  call wilder#setup({
    \   'modes': [':', '/', '?'],
    \ })
  call wilder#set_option('pipeline', [
    \   wilder#branch(
    \     wilder#cmdline_pipeline({
    \       'language': 'lua',
    \       'fuzzy': 1,
    \       'fuzzy_filter': wilder#lua_fzy_filter(),
    \     }),
    \     wilder#python_search_pipeline({
    \       'pattern': wilder#python_fuzzy_pattern(),
    \       'sorter': wilder#python_difflib_sorter(),
    \       'engine': 're',
    \     }),
    \   ),
    \ ])
  let s:highlighters = [
    \   wilder#pcre2_highlighter(),
    \   has('nvim') ? wilder#lua_fzy_highlighter() : wilder#cpsm_highlighter(),
    \ ]
  let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
    \   'border': 'rounded',
    \   'empty_message': wilder#popupmenu_empty_message_with_spinner(),
    \   'highlighter': s:highlighters,
    \   'left': [
    \     ' ',
    \     wilder#popupmenu_devicons(),
    \     wilder#popupmenu_buffer_flags({
    \       'flags': ' a + ',
    \       'icons': {'+': '', 'a': '', 'h': ''},
    \     }),
    \   ],
    \   'right': [
    \     ' ',
    \     wilder#popupmenu_scrollbar(),
    \   ],
    \ }))
  let s:lightline_renderer = wilder#wildmenu_renderer(
    \ wilder#wildmenu_lightline_theme({
    \   'hilights': {},
    \   'highlighter': s:highlighters,
    \   'separator': ' | ',
    \ }))

  let s:wildmenu_renderer = wilder#wildmenu_renderer({
    \   'highlighter': s:highlighters,
    \   'separator': ' · ',
    \   'left': [' ', wilder#wildmenu_spinner(), ' '],
    \   'right': [' ', wilder#wildmenu_index()],
    \ })

  call wilder#set_option('renderer', wilder#renderer_mux({
    \   ':': s:popupmenu_renderer,
    \   '/': s:lightline_renderer,
    \   'substitute': s:wildmenu_renderer,
    \ }))
endfunction
autocmd CmdlineEnter * ++once call s:wilder_init()
