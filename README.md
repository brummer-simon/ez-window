Easy Window
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/brummer-simon/ez-window/blob/master/LICENSE)
==========

Note: This is a fork of the amazing [ez-window](https://github.com/AnotherProksY/ez-window).
All credits go in this direction. I forked this repo for my own customization needs.
If you still not afraid to use it, here is a list of my changes:

* Use ESC to leave resize-mode instead of q
* Remove window navigation


#### Resize Mode

![Imgur](https://i.imgur.com/fTQkxD4.gif?1)

#### Open Terminal

![Imgur](https://i.imgur.com/ib8AuSN.gif?1)

How to use
------------

1. Window Navigation:

  - Use `<C-hjkl>` to navigate between splits.
  - Will create a new window, if it didn't exist earlier or move to an existing one.

2. Resize Mode:
  - `<C-m>` launches resize mode.
  - Use default `<hjkl>` keys to adjust the split size.
  - `<ESC>` to finish.

3. Open Terminal:
  - `<C-t>` to *open / close* terminal.
  - Use default `<C-\><C-n>` mapping to return to normal mode inside terminal split.

Installation
------------

* Manual
  * Copy `plugin/ez-window.vim` to `~/.vim/plugin`
* [Pathogen](https://github.com/tpope/vim-pathogen)
  * `git clone git://github.com/brummer-simon/ez-window.git ~/.vim/bundle/vim-ez-window`
* [Vundle](https://github.com/VundleVim/Vundle.vim)
  * `Plugin 'brummer-simon/ez-window'`
* [Vim-Plug](https://github.com/junegunn/vim-plug)
  * `Plug 'brummer-simon/ez-window'`

Default Mappings
---------

    <C-m>  : Enters into Resize Mode.
    <C-t>  : Open terminal split.

Customize Mappings
---------

```vim
" Change default 'Window Resize' mode mapping:
let g:resize_start_key = '<C-r>'  " or any key you want

" Change 'Open Terminal' mapping:
let g:ez_terminal_key = '<C-o>'   " or any key you want
```
