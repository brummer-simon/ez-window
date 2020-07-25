" Simple and small plugin for fast navigation between windows.
" Maintainer:	AnotherProksY <k.fazilov@icloud.com>
" Repository: https://github.com/AnotherProksY/ez-window

if exists('g:loaded_ezwindow') || &cp
  finish
end
let g:loaded_ezwindow = 1


" Create/Change Splits
function! s:EzWindow(key)
  let t:curwin = winnr()
  exec "wincmd " . a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd " . a:key | enew
  endif
endfunction


" Create New Terminal split (Only for NeoVim Users)
function! s:NewTerminal()
    if has('nvim')
        if exists('t:terminal_buffer')
            exe t:terminal_buffer . "wincmd c"
            unlet t:terminal_buffer
        else
            botright split
            let t:terminal_buffer = winnr()
            resize 10
            terminal
            normal i
        endif
    else
        echo "Sorry, you are not a 'NeoVim' user ;("
    endif
endfunction


function! s:ResizeCommands()
  let behavior = s:getResizeBehavior()
  let commands = {
        \  'left'   : ':vertical resize ' . behavior['left']  . '1',
        \  'right'  : ':vertical resize ' . behavior['right'] . '1',
        \  'up'     : ':resize ' . behavior['up']   . '1',
        \  'down'   : ':resize ' . behavior['down'] . '1',
        \}
  return commands
endfun


let s:codeList = {
     \  'left'  :'104',
     \  'down'  :'106',
     \  'up'    :'107',
     \  'right' :'108',
     \  'finish' :'113',
     \}


function! s:getEdgeInfo()
  let chk_direct = ['left', 'down', 'up', 'right']
  let result = {}
  for direct in chk_direct
    exe 'let result["' . direct . '"] = ' . !s:canMoveCursorFromCurrentWindow(direct)
  endfor
  return result
endfun


function! s:canMoveCursorFromCurrentWindow(direct, mode)
  let map_direct = {'left':'h', 'down':'j', 'up':'k', 'right':'l'}
  if has_key(map_direct, a:direct)
    let direct = map_direct[a:direct]
  elseif index(values(map_direct), a:direct) != -1
    let direct = a:direct
  endif
  let from = winnr()
  exe "wincmd " . direct
  let to = winnr()
  exe from . "wincmd w"
  return from != to
endfun


function! s:getResizeBehavior()
  let signs = {'left':'-', 'down':'+', 'up':'-', 'right':'+'}
  let ei = s:getEdgeInfo()
  if !ei['left'] && ei['right']
    let signs['left'] = '+'
    let signs['right'] = '-'
  endif
  if !ei['up'] && ei['down']
    let signs['up'] = '+'
    let signs['down'] = '-'
  endif
  return signs
endfun


" Resize Splits
function! s:ResizeMode(commands)
    echo "Start Resizing. Press 'q' to quit"

    let l:commands = a:commands

    while 1
        let l:c = getchar()

        if c == s:codeList['left'] "h
            exec l:commands['left']
        elseif c == s:codeList['down'] "j
            exec l:commands['down']
        elseif c == s:codeList['up'] "k
            exec l:commands['up']
        elseif c == s:codeList['right'] "l
            exec l:commands['right']
        elseif c == s:codeList['finish'] "q
            redraw
            echo "Finished!"
            break
        endif
        redraw
    endwhile
endfunction


" Commands
com! EzWindowGoLeft call s:EzWindow('h')
com! EzWindowGoDown call s:EzWindow('j')
com! EzWindowGoUp call s:EzWindow('k')
com! EzWindowGoRight call s:EzWindow('l')
com! EzWindowStartResize call s:ResizeMode(s:ResizeCommands())
com! EzWindowNewTerminal call s:NewTerminal()


" Mapping
nmap <silent> <C-h> :EzWindowGoLeft<CR>
nmap <silent> <C-j> :EzWindowGoDown<CR>
nmap <silent> <C-k> :EzWindowGoUp<CR>
nmap <silent> <C-l> :EzWindowGoRight<CR>
nmap <silent> <C-m> :EzWindowStartResize<CR>
nmap <silent> <C-t> :EzWindowNewTerminal<CR>
