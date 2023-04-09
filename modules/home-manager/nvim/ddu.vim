call ddu#custom#alias('source', 'find', 'file_external')
call ddu#custom#alias('source', 'grep', 'rg')

let s:sourceOptions = {}
let s:sourceOptions._ = #{
      \   ignoreCase: v:true,
      \   matchers: [ 'matcher_fzf' ],
      \ }
let s:sourceOptions.grep = #{
      \ ignoreCase: v:true,
      \ matchers: [ 'ddu-filter-converter_display_word', 'matcher_fzf' ],
      \ }

let s:kindOptions = {}
let s:kindOptions.file = #{ defaultAction: 'open', delay: 100, }

let s:sourceParams = {}
let s:sourceParams.find = #{
      \ cmd: [ 'fd', '.' ],
      \ }
let s:sourceParams.grep = #{
      \ args: [ '--column', '--no-heading' ],
      \ }

let s:uiParams = {}
let s:uiParams.ff = #{
      \ startFilter: v:true,
      \ split: 'floating',
      \ floatingBorder: 'single',
      \ prompt: '',
      \ autoAction: #{ name: 'preview' },
      \ previewSplit: 'horizontal',
      \ ignoreEmpty: v:true,
      \ autoResize: v:false,
      \ }

let s:filterParams = {}
let s:filterParams.matcher_substring = #{}
let s:filterParams.matcher_fzf = #{
      \ highlightMatched: 'Search',
      \ }

let s:patch_global = {}
let s:patch_global.ui = 'ff'
let s:patch_global.sources = []
let s:patch_global.sourceOptions = s:sourceOptions
let s:patch_global.sourceParams = s:sourceParams
let s:patch_global.kindOptions = s:kindOptions
let s:patch_global.uiParams = s:uiParams
let s:patch_global.filterParams = s:filterParams

call ddu#custom#patch_global(s:patch_global)

function! s:ddu_send_all_to_qf() abort
  call ddu#ui#do_action('clearSelectAllItems')
  call ddu#ui#do_action('toggleAllItems')
  call ddu#ui#do_action('itemAction', #{ name: 'quickfix'})
endfunction

function! s:ddu_settings() abort
  setlocal cursorline
  nnoremap <buffer><silent> <CR>  <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> i     <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q     <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  nnoremap <buffer><silent> <C-c> <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

function! s:ddu_filter_settings() abort
  autocmd TextChangedI,TextChangedP <buffer> call ddu#ui#ff#_do_auto_action()
  nnoremap <buffer><silent> <CR>  <Cmd>call ddu#ui#do_action('itemAction')<CR>
  nnoremap <buffer><silent> q     <Cmd>call ddu#ui#do_action('leaveFilterWindow')<CR>
  nnoremap <buffer><silent> <C-c> <Cmd>call ddu#ui#do_action('quit')<CR>

  inoremap <buffer><silent> <CR>  <Cmd>call ddu#ui#do_action('itemAction')<CR>
  inoremap <buffer><silent> <C-q> <Cmd>call <SID>ddu_send_all_to_qf()<CR>
  inoremap <buffer><silent> <C-p> <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)<Bar>redraw")<CR>
  inoremap <buffer><silent> <C-n> <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)<Bar>redraw")<CR>
  inoremap <buffer><silent> <C-c> <Cmd>call ddu#ui#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff call s:ddu_settings()
autocmd FileType ddu-ff-filter call s:ddu_filter_settings()
autocmd BufAdd * if &l:buftype == 'nofile' | setlocal nobuflisted | endif

function! s:ddu_grep() abort
  call ddu#start(#{
      \ volatile: v:true,
      \ sources: [#{
      \   name: 'grep',
      \   options: #{matchers: []},
      \ }],
      \ })
endfunction
function! s:ddu_find() abort
  call ddu#start(#{
      \ sources: [#{ name: 'find' }],
      \ uiParams: #{
      \   ff: #{
      \     startFilter: v:true,
      \     split: 'floating',
      \     floatingBorder: 'single',
      \     prompt: '',
      \     autoAction: #{ name: 'preview' },
      \     previewSplit: 'no',
      \     ignoreEmpty: v:true,
      \     autoResize: v:false,
      \   },
      \ },
      \ })
endfunction

command! DduGrep call <SID>ddu_grep()
command! DduFind call <SID>ddu_find()
