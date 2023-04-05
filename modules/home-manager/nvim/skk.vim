call skkeleton#config({
      \ 'globalJisyo': s:args['jisyo_path'],
      \ 'globalJisyoEncoding': 'utf-8',
      \ 'useSkkServer': v:true,
      \ 'skkServerHost': '127.0.0.1',
      \ 'skkServerPort': 1178,
      \ 'skkServerReqEnc': 'euc-jp',
      \ 'skkServerResEnc': 'euc-jp',
      \ 'markerHenkan': '',
      \ 'markerHenkanSelect': '',
      \ })
imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)
