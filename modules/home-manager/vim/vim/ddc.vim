let s:sources = [
      \ 'nvim-lsp',
      \ 'around',
      \ 'buffer',
      \ 'file',
      \ ]

let s:sourceOptions = {}
let s:sourceOptions._ = {
      \ 'ignoreCase': v:true,
      \ 'matchers': ['matcher_fuzzy'],
      \ 'sorters': ['sorter_fuzzy'],
      \ 'converters': [
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
      \ }
let s:sourceOptions.buffer = {
      \ 'mark': 'B',
      \ }

let s:sourceOptions['nvim-lsp'] = {
      \ 'mark': 'LSP',
      \ 'isVolatile': v:true,
      \ 'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \ }

let s:sourceParams = {}

let s:filterParams = {}

let s:patch_global = {}
let s:patch_global.ui = 'pum'
let s:patch_global.autoCompleteEvents = [ 'InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineEnter', 'CmdlineChanged' ]
let s:patch_global.sources = s:sources
let s:patch_global.sourceOptions = s:sourceOptions
let s:patch_global.sourceParams = s:sourceParams
let s:patch_global.filterParams = s:filterParams

call ddc#custom#patch_global(s:patch_global)

call ddc#enable()
call signature_help#enable()
call popup_preview#enable()

function! CR() abort
  if pum#visible()
    return "\<Cmd>call pum#map#confirm()\<CR>"
  else
    return "\<CR>"
  endif
endfunction

" inoremap <C-n> <Cmd>call pum#map#select_relative(+1)<CR>
" inoremap <C-p> <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <silent><expr> <TAB>   pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : vsnip#jumpable(+1) ? '<Plug>(vsnip-jump-next)' : '<TAB>'
inoremap <silent><expr> <S-TAB> pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-TAB>'
inoremap <silent><expr> <C-n>   (pum#visible() ? '' : '<Cmd>call ddc#map#manual_complete()<CR>') . '<Cmd>call pum#map#select_relative(+1)<CR>'
inoremap <silent><expr> <C-p>   (pum#visible() ? '' : '<Cmd>call ddc#map#manual_complete()<CR>') . '<Cmd>call pum#map#select_relative(-1)<CR>'
inoremap <C-e> <Cmd>call pum#map#cancel()<CR>
inoremap <silent><expr> <CR> CR()

autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
