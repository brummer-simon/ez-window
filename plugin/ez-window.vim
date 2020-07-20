" Simple and small plugin for fast navigation between windows.
" Maintainer:	AnotherProksY <k.fazilov@icloud.com>
" Repository: https://github.com/AnotherProksY/ez-window

if exists('g:loaded_ezwindow') || &cp
  finish
end
let g:loaded_ezwindow = 1


function! EzWindow(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key | enew
  endif
endfunction


" Mapping
nmap <silent> <C-h> :call EzWindow('h')<CR>
nmap <silent> <C-j> :call EzWindow('j')<CR>
nmap <silent> <C-k> :call EzWindow('k')<CR>
nmap <silent> <C-l> :call EzWindow('l')<CR>
