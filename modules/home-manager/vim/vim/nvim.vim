"https://qiita.com/yasunori-kirin0418/items/4672919be73a524afb47
"DisableTOhtml.
let g:loaded_2html_plugin=1
"Disablearchivefileopenandbrowse.
let g:loaded_gzip=1
let g:loaded_tar=1
let g:loaded_tarPlugin=1
let g:loaded_zip=1
let g:loaded_zipPlugin=1
"Disablevimball.
let g:loaded_vimball=1
let g:loaded_vimballPlugin=1
"Disablenetrwplugins.
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1
let g:loaded_netrwSettings=1
let g:loaded_netrwFileHandlers=1
"Disable`GetLatestVimScript`.
let g:loaded_getscript=1
let g:loaded_getscriptPlugin=1
"Disableotherplugins
let g:loaded_man=1
let g:loaded_matchit=1
let g:loaded_matchparen=1
let g:loaded_shada_plugin=1
let g:loaded_spellfile_plugin=1
let g:loaded_tutor_mode_plugin=1
let g:did_install_default_menus=1
let g:did_install_syntax_menu=1
let g:skip_loading_mswin=1
let g:did_indent_on=1
let g:did_load_ftplugin=1
let g:loaded_rrhelper=1

set splitkeep=screen

augroup GrepCmd
  autocmd!
  autocmd QuickFixCmdPost [^l]* nested lua require("toolwindow").open_window("quickfix", {stay_after_open = true})
  autocmd QuickFixCmdPost    l* nested lopen
augroup END
