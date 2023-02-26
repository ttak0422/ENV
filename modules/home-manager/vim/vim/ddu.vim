let s:sources = [
      \   #{ name: 'file' },
      \   #{ name: 'buffer' },
      \ ]

let s:sourceOptions = {}
let s:sourceOptions._ = #{
      \   matchers: [ 'matcher_substring' ],
      \ }

let s:kindOptions = {}
let s:kindOptions.file = #{
      \   defaultAction: 'open',
      \ }

let s:uiParams = {}
let s:uiParams.ff = #{
      \   highlights: #{ floating: 'Search', prompt: 'Special', selected: 'Underlined' },
      \ }
      " \   startFilter: v:true,

let s:filterParams = {}
let s:filterParams.matcher_substring = #{}

let s:patch_global = {}
let s:patch_global.ui = 'ff'
let s:patch_global.sources = s:sources
let s:patch_global.sourceOptions = s:sourceOptions
let s:patch_global.kindOptions = s:kindOptions
let s:patch_global.uiParams = s:uiParams
let s:patch_global.filterParams = s:filterParams

call ddu#custom#patch_global(s:patch_global)

function! s:ddu_settings() abort
  nnoremap <buffer><silent> <CR>  <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <C-c> <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> i     <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q     <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  nnoremap <buffer><silent> <ESC> <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

function! s:ddu_filter_settings() abort
  inoremap <buffer><silent> <CR>  <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  inoremap <buffer><silent> <C-q> <Cmd>call ddu#ui#ff#do_action('quickfix')<CR>
	inoremap <buffer><silent> <C-j> <Cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)")<CR>
	inoremap <buffer><silent> <C-k> <Cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)")<CR>
  inoremap <buffer><silent> q     <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  nnoremap <buffer><silent> q     <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  inoremap <buffer><silent> <C-c> <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff call s:ddu_settings()
autocmd FileType ddu-ff-filter call s:ddu_filter_settings()
