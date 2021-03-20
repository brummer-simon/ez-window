" Simple and small plugin for fast navigation between windows.
" Maintainer:	AnotherProksY <k.fazilov@icloud.com>
" Repository: https://github.com/AnotherProksY/ez-window


if exists('g:loaded_ez_window') || &cp
  finish
end
let g:loaded_ez_window = 1


let s:save_cpo = &cpo
set cpo&vim


" Create/Change Splits
function! s:EzWindow(key)
  if (g:ez_window_splits)
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
  else
    exec "wincmd " . a:key
  endif
endfunction


" Create New Terminal split (Only for NeoVim Users)
function! s:NewTerminal()
  if has('nvim')
    if exists('t:terminal_buffer')
      if (bufwinid(t:terminal_buffer) > 0)
        exe "bd! " . t:terminal_buffer
        unlet t:terminal_buffer
      else
        botright split
        resize 10
        terminal
        let t:terminal_buffer = bufnr()
        normal i   
      endif
    else
      botright split
      resize 10
      terminal
      let t:terminal_buffer = bufnr()
      normal i
    endif
  else
    if exists('t:terminal_buffer')
      if (bufwinid(t:terminal_buffer) > 0)
        exe "bd! " . t:terminal_buffer
        unlet t:terminal_buffer
      else
        botright terminal ++rows=10
        let t:terminal_buffer = bufnr()
      endif
    else
      botright terminal ++rows=10
      let t:terminal_buffer = bufnr()
    endif
  endif
endfunction


" List of commands for 'Resize Mode'
function! s:ResizeCommands()
  let behavior = s:GetResizeBehavior()
  let commands = {
        \  'left'   : ':vertical resize ' . behavior['left']  . '1',
        \  'right'  : ':vertical resize ' . behavior['right'] . '1',
        \  'up'     : ':resize ' . behavior['up']   . '1',
        \  'down'   : ':resize ' . behavior['down'] . '1',
        \}
  return commands
endfun


" List of ASCII codes for each symbol
let s:code_list = {
     \  'left'   :'104',
     \  'down'   :'106',
     \  'up'     :'107',
     \  'right'  :'108',
     \  'finish' :'113',
     \}


" Create mapping for allowed directions in current split
function! s:GetEdgeInfo()
  let chk_direct = ['left', 'down', 'up', 'right']
  let result = {}
  for direct in chk_direct
    exe 'let result["' . direct . '"] = ' . !s:CanMoveCursorFromCurrentWindow(direct)
  endfor
  return result
endfun


" Get information about current split position
function! s:CanMoveCursorFromCurrentWindow(direct)
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


" Create correct mapping for resize movement
function! s:GetResizeBehavior()
  let signs = {'left':'-', 'down':'+', 'up':'-', 'right':'+'}
  let ei = s:GetEdgeInfo()
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

    if c == s:code_list['left'] "h
      exec l:commands['left']
    elseif c == s:code_list['down'] "j
      exec l:commands['down']
    elseif c == s:code_list['up'] "k
      exec l:commands['up']
    elseif c == s:code_list['right'] "l
      exec l:commands['right']
    elseif c == s:code_list['finish'] "q
      redraw
      echo "Finished!"
      break
    endif
    redraw
  endwhile
endfunction


" List of Commands
com! EzWindowGoLeft call s:EzWindow('h')
com! EzWindowGoDown call s:EzWindow('j')
com! EzWindowGoUp call s:EzWindow('k')
com! EzWindowGoRight call s:EzWindow('l')
com! EzWindowStartResize call s:ResizeMode(s:ResizeCommands())
com! EzWindowNewTerminal call s:NewTerminal()


" List of Mappings
let s:default_start_key = '<C-m>'
let s:default_ez_window_keys = {
            \ 'left'  : '<C-h>',
            \ 'down'  : '<C-j>',
            \ 'up'    : '<C-k>',
            \ 'right' : '<C-l>',
            \}
let s:default_ez_terminal_key = '<C-t>'


let g:resize_start_key = get(g:, 'resize_start_key', s:default_start_key)
let g:ez_terminal_key = get(g:, 'ez_terminal_key', s:default_ez_terminal_key)
let g:ez_window_splits = get(g:, 'ez_window_splits', 1)


exe 'nnoremap <silent> '. g:resize_start_key .' :EzWindowStartResize<CR>'
exe 'nnoremap <silent> '. s:default_ez_window_keys['left'] .' :EzWindowGoLeft<CR>'
exe 'nnoremap <silent> '. s:default_ez_window_keys['down'] .' :EzWindowGoDown<CR>'
exe 'nnoremap <silent> '. s:default_ez_window_keys['up'] .' :EzWindowGoUp<CR>'
exe 'nnoremap <silent> '. s:default_ez_window_keys['right'] .' :EzWindowGoRight<CR>'
exe 'nnoremap <silent> '. g:ez_terminal_key .' :EzWindowNewTerminal<CR>'

if (g:ez_window_splits == 0)
  exe 'nnoremap <silent> <leader>- :split \| enew<CR>'
  exe 'nnoremap <silent> <leader>_ :vsplit \| enew<CR>'
endif


let &cpo = s:save_cpo
