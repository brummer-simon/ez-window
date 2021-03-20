Easy Window
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/AnotherProksY/ez-window/blob/master/LICENSE)
==========
Simple and small plugin for easy resizing and fast navigation between windows.

#### Window Navigation

![Imgur](https://i.imgur.com/SOBhnQm.gif?1)

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
  - `<q>` to finish.

3. Open Terminal:
  - `<C-t>` to *open / close* terminal.
  - Use default `<C-\><C-n>` mapping to return to normal mode inside terminal split.

Installation
------------

* Manual
  * Copy `plugin/ez-window.vim` to `~/.vim/plugin`
* [Pathogen](https://github.com/tpope/vim-pathogen)
  * `git clone git://github.com/AnotherProksY/ez-window.git ~/.vim/bundle/vim-ez-window`
* [Vundle](https://github.com/VundleVim/Vundle.vim)
  * `Plugin 'AnotherProksY/ez-window'`
* [Vim-Plug](https://github.com/junegunn/vim-plug)
  * `Plug 'AnotherProksY/ez-window'`

Default Mappings
---------

    <C-h>  : New window or Move Left.
    <C-j>  : New window or Move Down.
    <C-k>  : New window or Move Up.
    <C-l>  : New window or Move Right.
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
