set laststatus=2
set showtabline=2
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"
let g:lightline = {
  \   'colorscheme': 'ayu_mirage',
  \   'active': {
  \     'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'gitdiff'] ],
  \     'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
  \                [ 'fileformat', 'fileencoding', 'filetype'] ],
  \   },
  \   'tabline': {
  \     'left': [ ['buffers'] ],
  \     'right': [ ['close'] ],
  \   },
  \   'separator': {
  \     'left': "\ue0b4",
  \     'right': "\ue0b6",
  \   },
  \   'subseparator': {
  \     'left': "\ue0b5",
  \     'right': "\ue0b7",
  \   },
  \   'component_function': {
  \     'filename': 'LightlineFilename',
  \     'gitbranch': 'LightlineGitBranch',
  \     'gitdiff': 'LightlineGitDiff',
  \   },
  \   'component_expand': {
  \     'buffers': 'lightline#bufferline#buffers',
  \     'linter_checking': 'lightline#ale#checking',
  \     'linter_infos': 'lightline#ale#infos',
  \     'linter_warnings': 'lightline#ale#warnings',
  \     'linter_errors': 'lightline#ale#errors',
  \     'linter_ok': 'lightline#ale#ok',
  \   },
  \   'component_type': {
  \     'buffers': 'tabsel',
  \     'linter_infos': 'right',
  \     'linter_warnings': 'warning',
  \     'linter_errors': 'error',
  \     'linter_ok': 'right',
  \     'gitdiff': 'middle',
  \   },
  \   'mode_map': {
  \     'n' : ' NOR',
  \     'i' : ' INS',
  \     'R' : ' REP',
  \     'v' : ' VIS',
  \     'V' : ' VIS',
  \     "\<C-v>": ' VIS',
  \     'c' : ' CMD',
  \     's' : ' SEL',
  \     'S' : ' SEL',
  \     "\<C-s>": ' SEL',
  \     't': ' TRM',
  \   }
  \ }

function! LightlineFilename()
  return expand('%')
endfunction

function! LightlineGitDiff()
  return get(b:,'gitsigns_status')
endfunction

function! LightlineGitBranch()
  return ' ' . get(b:,'gitsigns_head')
endfunction

