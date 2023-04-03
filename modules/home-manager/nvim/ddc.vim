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
      \ 'mark': 'A',
      \ 'maxItems': 50,
      \ }
let s:sourceOptions.file = {
      \ 'mark': 'F',
      \ 'forceCompletionPattern': '\S/\S*',
      \ }
let s:sourceOptions.buffer = {
      \ 'mark': 'B',
      \ }
let s:sourceOptions.skkeleton = {
      \ 'mark': 'S',
      \ 'matchers': ['skkeleton'],
      \ }
let s:sourceOptions['nvim-lsp'] = {
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
let s:sourceOptions['nvim-obsidian'] = #{
      \   mark: ' ',
      \ }
let s:sourceOptions['nvim-obsidian-new'] = #{
      \   mark: ' +',
      \ }

let s:sourceParams = {}
let s:sourceParams['nvim-lsp'] = #{
      \  kindLabels: #{
      \    Text: '',
      \    Method: '',
      \    Function: 'λ',
      \    Constructor: '',
      \    Field: '',
      \    Variable: ' ',
      \    Class: '',
      \    Interface: '',
      \    Module: '',
      \    Property: '',
      \    Unit: '',
      \    Value: '',
      \    Enum: '',
      \    Keyword: '',
      \    Snippet: '﬌',
      \    Color: '',
      \    File: '',
      \    Reference: '',
      \    Folder: '',
      \    EnumMember: '',
      \    Constant: '',
      \    Struct: 'פּ',
      \    Event: '',
      \    Operator: '',
      \    TypeParameter: '',
      \   },
      \   maxItems: 800,
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
let s:filterParams.converter_truncate = { 'maxAbbrWidth': 60, 'maxKindWidth': 5, 'maxMenuWidth': 40 }

let s:patch_global = {}
let s:patch_global.ui = 'pum'
let s:patch_global.keywordPattern = '[a-zA-Z_]\w*'
" let s:patch_global.ui = 'native'
let s:patch_global.autoCompleteEvents = [ 'InsertEnter', 'TextChangedI', 'TextChangedP' ]
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
      \ converter_truncate: #{ maxAbbrWidth: 60, maxKindWidth: 5, maxMenuWidth: 0 },
      \ sorter_itemsize: #{ sameWordOnly: v:true },
      \ })

call ddc#enable()
call signature_help#enable()
let g:popup_preview_config = #{
      \ border: v:false,
      \ }
call popup_preview#enable()

inoremap <silent> <C-x><C-f> <Cmd>call ddc#map#manual_complete(#{ sources: ['file'] })<CR>
inoremap <silent> <C-x><C-t> <Cmd>call ddc#map#manual_complete(#{ sources: ['tmux'] })<CR>
inoremap <silent> <C-x><C-b> <Cmd>call ddc#map#manual_complete(#{ sources: ['buffer'] })<CR>

" for Obsidian
function! Obsidian() abort
  call ddc#custom#patch_buffer('sources', ['nvim-obsidian', 'around', 'nvim-obsidian-new'])
endfunction
autocmd BufRead,BufNewFile **/vault/**/*.md call Obsidian()
autocmd BufRead,BufNewFile **/vault/*.md call Obsidian()

" vsnip
inoremap <expr> <C-k> vsnip#jumpable(+1) ? '<Plug>(vsnip-jump-next)' : ''
snoremap <expr> <C-k> vsnip#jumpable(+1) ? '<Plug>(vsnip-jump-next)' : ''
inoremap <expr> <C-l> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : ''
snoremap <expr> <C-l> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : ''
