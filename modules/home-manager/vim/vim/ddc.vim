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
      \ 'matchers': [
      \   'matcher_fuzzy'
      \ ],
      \ 'sorters': [
      \   'sorter_fuzzy'
      \ ],
      \ 'converters': [
      \   'converter_remove_overlap',
      \   'converter_truncate',
      \   'converter_fuzzy',
      \ ],
      \ 'forceCompletionPattern': '\S+',
      \ }
let s:sourceOptions.around = {
      \ 'mark': 'A',
      \ 'maxItems': 5,
      \ }
let s:sourceOptions.file = {
      \ 'mark': 'F',
      \ 'forceCompletionPattern': '\S/\S*',
      \ 'trailingSlash': v:true,
      \ 'projAsRoot': v:true,
      \ 'bufAsRoot': v:true,
      \ }
let s:sourceOptions.buffer = {
      \ 'mark': 'B',
      \ }
let s:sourceOptions.skkeleton = {
      \ 'mark': 'S',
      \ 'matchers': ['skkeleton'],
      \ }
let s:sourceOptions['nvim-lsp'] = {
      \ 'mark': 'L',
      \ 'dup': 'keep',
      \ 'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \ }
let s:sourceOptions.tmux = {
      \ 'mark': 'T',
      \ }
let s:sourceOptions.necovim = {
      \ 'mark': 'V',
      \ }
let s:sourceOptions.cmdline = {
      \ 'mark': 'cmdline',
      \ }
let s:sourceOptions['cmdline-history'] = {
      \ 'mark': 'history',
      \ }

let s:sourceParams = {}
let s:sourceParams['nvim-lsp'] = #{
      \  kindLabels: #{
      \    Class: '',
      \    Text: '',
      \    Method: '',
      \    Function: '',
      \    constructor: '',
      \    Field: 'ﰠ',
      \    Variable: '𝒙',
      \    Interface: '',
      \    Module: '',
      \    Property: '',
      \    Unit: '',
      \    Value: '',
      \    Enum: '',
      \    Key: '',
      \    Snippet: '﬌',
      \    Color: '',
      \    File: '',
      \    Reference: '',
      \    Folder: '',
      \    EnumMember: '',
      \    Constant: '',
      \    Struct: '',
      \    Event: '',
      \    Operator: '',
      \    TypeParameter: '',
      \ }
      \ }
let s:sourceParams.tmux = {
      \ 'currentWinOnly': v:true,
      \ 'excludeCurrentPane': v:true,
      \ 'kindFormat': '#{pane_current_command}',
      \ 'maxItems': 5,
      \ }

let s:filterParams = {}
let s:filterParams.converter_truncate = {
      \ 'maxKindWidth': 5,
      \ }

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
        \   'minAutoCompleteLength': 2,
        \   'maxItems': 15,
        \ }})
  call ddc#custom#patch_buffer('cmdlineSources', {
        \ ':': ['necovim', 'cmdline', 'cmdline-history','around'],
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

