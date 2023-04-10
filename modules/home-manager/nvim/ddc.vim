let s:sources = [
      \ 'nvim-lsp',
      \ 'around',
      \ ]

let s:sourceOptions = {}
let s:sourceOptions._ = {
      \ 'ignoreCase': v:true,
      \ 'matchers': [
      "\   'matcher_length',
      \   'matcher_fuzzy',
      \ ],
      \ 'sorters': ['sorter_fuzzy'],
      \ 'converters': [
      \   'converter_remove_overlap',
      \   'converter_truncate',
      \   'converter_fuzzy',
      \ ],
      \ 'dup': 'ignore',
      \ 'minKeywordLength': 2,
      \ }
let s:sourceOptions.around = {
      \ 'mark': '[AROUND]',
      \ 'maxItems': 50,
      \ }
let s:sourceOptions.line= {
      \ 'mark': '[LINE]',
      \ 'maxItems': 50,
      \ }
let s:sourceOptions.file = {
      \ 'mark': '[FILE]',
      \ 'forceCompletionPattern': '\S/\S*',
      \ }
let s:sourceOptions.buffer = {
      \ 'mark': '[BUFF]',
      \ }
let s:sourceOptions.skkeleton = {
      \ 'mark': '[SKK]',
      \ 'matchers': ['skkeleton'],
      \ }
let s:sourceOptions['nvim-lsp'] = {
      \ 'mark': '[LSP]',
      \ 'dup': 'keep',
      \ 'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \ }
let s:sourceOptions.tmux = {
      \ 'mark': '[TMUX]',
      \ }
let s:sourceOptions.necovim = {
      \ 'mark': '[VIM]',
      \ }
let s:sourceOptions.cmdline = {
      \ 'mark': '[CMD]',
      \ }
let s:sourceOptions['cmdline-history'] = {
      \ 'mark': '[HIST]',
      \ }
let s:sourceOptions['nvim-obsidian'] = #{
      \   mark: ' ',
      \ }
let s:sourceOptions['nvim-obsidian-new'] = #{
      \   mark: ' +',
      \ }

let s:sourceParams = {}
let s:sourceParams['nvim-lsp'] = #{
      \   maxitems: 800,
      \ }
let s:sourceParams.tmux = {
      \ 'currentWinOnly': v:true,
      \ 'excludeCurrentPane': v:true,
      \ 'kindFormat': '#{pane_current_command}',
      \ }
let s:sourceParams.file = {
      \ 'projAsRoot': v:true,
      \ 'bufAsRoot': v:true,
      \ }
let s:sourceParams['nvim-obsidian'] = #{
      \   dir: '~/vault',
      \ }
let s:sourceParams['nvim-obsidian-new'] = #{
      \   dir: '~/vault',
      \ }

let s:filterParams = {}
let s:filterParams.converter_truncate = { 'maxAbbrWidth': 60, 'maxKindWidth': 10, 'maxMenuWidth': 40 }

let s:patch_global = {}
let s:patch_global.ui = 'pum'
let s:patch_global.keywordPattern = '[0-9a-zA-Z_]\w*'
" let s:patch_global.ui = 'native'
let s:patch_global.autoCompleteEvents = [
    \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
    \ 'CmdlineChanged',
    \ ]

" let s:patch_global.autoCompleteDelay = 100
let s:patch_global.backspaceCompletion = v:true
let s:patch_global.sources = s:sources
let s:patch_global.sourceOptions = s:sourceOptions
let s:patch_global.sourceParams = s:sourceParams
let s:patch_global.filterParams = s:filterParams
call ddc#custom#patch_global(s:patch_global)

" for Java
call ddc#custom#patch_filetype(['java'], 'sourceOptions', #{
      \ _: #{
      \   sorters: ['sorter_itemsize', 'sorter_fuzzy'],
      \ }})
call ddc#custom#patch_filetype(['java'], 'filterParams', #{
      \ converter_truncate: #{ maxAbbrWidth: 60, maxKindWidth: 10, maxMenuWidth: 0 },
      \ sorter_itemsize: #{ sameWordOnly: v:true },
      \ })
" for Vim
call ddc#custom#patch_filetype(['vim'], #{
      \ sources: extend(['necovim'], s:sources),
      \ })

call ddc#enable()
call signature_help#enable()
let g:popup_preview_config = #{
      \ maxWidth: 100,
      \ }
call popup_preview#enable()

inoremap <silent> <C-x><C-f> <Cmd>call ddc#map#manual_complete(#{ sources: ['file'] })<CR>
inoremap <silent> <C-x><C-t> <Cmd>call ddc#map#manual_complete(#{ sources: ['tmux'] })<CR>
inoremap <silent> <C-x><C-b> <Cmd>call ddc#map#manual_complete(#{ sources: ['buffer'] })<CR>

" for Obsidian
function! s:obsidian() abort
  call ddc#custom#patch_buffer('sources', ['nvim-obsidian', 'around', 'nvim-obsidian-new'])
endfunction
autocmd BufRead,BufNewFile **/vault/**/*.md call s:obsidian()
autocmd BufRead,BufNewFile **/vault/*.md call s:obsidian()

" vsnip
inoremap <expr> <C-k> vsnip#jumpable(+1) ? '<Plug>(vsnip-jump-next)' : ''
snoremap <expr> <C-k> vsnip#jumpable(+1) ? '<Plug>(vsnip-jump-next)' : ''
inoremap <expr> <C-l> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : ''
snoremap <expr> <C-l> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : ''

" cmdline
call ddc#custom#patch_global('cmdlineSources', {
      \ ':': [ 'necovim', 'file', 'cmdline-history', 'cmdline', 'around' ],
      \ '@': [],
      \ '>': [],
      \ '/': [ 'around', 'line' ],
      \ '?': [ 'around', 'line' ],
      \ '-': [],
      \ '=': [ 'input' ],
      \ })
function! CommandlinePre() abort
  if !exists('b:prev_buffer_config')
    let b:prev_buffer_config = ddc#custom#get_buffer()
  endif

  autocmd User DDCCmdlineLeave ++once call CommandlinePost()
  autocmd InsertEnter <buffer> ++once call CommandlinePost()

  call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
  if exists('b:prev_buffer_config')
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  else
    call ddc#custom#set_buffer({})
  endif
endfunction

nnoremap : <Cmd>call CommandlinePre()<CR>:
nnoremap ? <Cmd>call CommandlinePre()<CR>?
nnoremap / <Cmd>call CommandlinePre()<CR>/
