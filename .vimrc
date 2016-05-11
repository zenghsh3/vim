syntax enable
set background=dark
let g:solarized_termcolors=256
"colorscheme dark

set number

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
execute pathogen#infect()
filetype plugin indent on

set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors


"map F9 to make and run
func! Make()
    exec "w"
    silent exec "!clear"
    silent exec "!echo '======================================'"
    exec "!python '%<'.py"
endfunc

nmap<F9> :call Make()<CR>
set clipboard=unnamed
