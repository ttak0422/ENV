let s:sources = [
      \ 'nvim-lsp',
      \ 'around',
      \ 'tmux',
      \ 'buffer',
      \ 'file',
      \ ]

let s:sourceOptions = {}
let s:sourceOptions._ = {
      \ 'ignoreCase': v:true,
      \ 'matchers': ['matcher_fuzzy'],
      \ 'sorters': ['sorter_fuzzy'],
      \ 'converters': [
      \   'converter_truncate',
      \   'converter_fuzzy',
      \ ],
      \ 'maxItems': 15,
      \ }
let s:sourceOptions.around = {
      \ 'mark': 'A',
      \ 'isVolatile': v:true,
      \ 'maxItems': 5,
      \ }
let s:sourceOptions.file = {
      \ 'mark': 'F',
      \ 'isVolatile': v:true,
      \ 'forceCompletionPattern': '\S/\S*',
      \ 'trailingSlash': v:true,
      \ 'projAsRoot': v:true,
      \ 'bufAsRoot': v:true,
      \ }
let s:sourceOptions.buffer = {
      \ 'mark': 'B',
      \ }
let s:sourceOptions.skkeleton = {
      \ 'mark': 'SKK',
      \ 'matchers': ['skkeleton'],
      \ 'isVolatile': v:true,
      \ }
let s:sourceOptions['nvim-lsp'] = {
      \ 'mark': 'LSP',
      \ 'dup': 'keep',
      \ 'isVolatile': v:true,
      \ 'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \ }
let s:sourceOptions.tmux = {
      \ 'mark': 'TMX',
      \ 'isVolatile': v:true,
      \ }
let s:sourceOptions.necovim = {
      \ 'mark': 'VIM',
      \ 'isVolatile': v:true,
      \ }
let s:sourceOptions.cmdline = {
      \ 'mark': 'cmdline',
      \ 'isVolatile': v:true,
      \ }
let s:sourceOptions['cmdline-history'] = {
      \ 'mark': 'history',
      \ 'isVolatile': v:true,
      \ }

let s:sourceParams = {}
let s:sourceParams.tmux = {
      \ 'currentWinOnly': v:true,
      \ 'excludeCurrentPane': v:true,
      \ 'kindFormat': '#{pane_current_command}',
      \ }

let s:filterParams = {}

let s:patch_global = {}
let s:patch_global.ui = 'pum'
" let s:patch_global.ui = 'native'
let s:patch_global.autoCompleteEvents = [ 'InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged' ]
let s:patch_global.backspaceCompletion = v:true
let s:patch_global.sources = s:sources
let s:patch_global.sourceOptions = s:sourceOptions
let s:patch_global.sourceParams = s:sourceParams
let s:patch_global.filterParams = s:filterParams

call ddc#custom#patch_global(s:patch_global)

call ddc#enable()
call signature_help#enable()
call popup_preview#enable()

nnoremap : <Cmd>call CommandlinePre()<CR>:
nnoremap / <Cmd>call CommandlinePre()<CR>/
nnoremap ? <Cmd>call CommandlinePre()<CR>?

function! CommandlinePre() abort
  cnoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
  cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
  cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
  if !exists('b:prev_buffer_config')
    let b:prev_buffer_config = ddc#custom#get_buffer()
  endif
  call ddc#custom#patch_buffer('sourceOptions', {
        \ '_': {
        \   'minAutoCompleteLength': 0,
        \ }})
  call ddc#custom#patch_buffer('cmdlineSources', {
        \ ':': ['necovim', 'cmdline-history', 'cmdline', 'around'],
        \ '/': ['around', 'buffer'],
        \ '?': ['around', 'buffer'],
        \ })

  autocmd User DDCCmdlineLeave ++once call CommandlinePost()
  autocmd InsertEnter <buffer> ++once call CommandlinePost()
  call ddc#enable_cmdline_completion()
endfunction

function! CommandlinePost() abort
  silent! cunmap <Tab>
  silent! cunmap <S-Tab>
  silent! cunmap <C-y>
  silent! cunmap <C-e>
  if exists('b:prev_buffer_config')
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  else
    call ddc#custom#set_buffer({})
  endif
endfunction

autocmd User PumCompleteDone call CommandlinePre()

