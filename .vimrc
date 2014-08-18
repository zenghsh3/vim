"---------------vundle----------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Valloric/ListToggle'
Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Yggdroot/indentLine'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

hi clear Normal
"-------------------------------------------------------------------------------
" map F9 to make & run
nmap <F9> :call Make()<CR><CR>:call Run()<CR>
imap <F9> <ESC>:call Make()<CR><CR>:call Run()<CR>
vmap <F9> <ESC>:call Make()<CR><CR>:call Run()<CR>

" map F10 to make & gdb
nmap <F10> :call Make()<CR><CR>:call Gdb()<CR>
imap <F10> <ESC>:call Make()<CR><CR>:call Gdb()<CR>
vmap <F10> <ESC>:call Make()<CR><CR>:call Gdb()<CR>

func! Make()
    exec "w"
    silent exec "!/home/sheng/.vim/remove ./'%<'"
    if &filetype=="c"
        setlocal makeprg=gcc\ '%'\ -o\ '%<'\ -g\ -O2\ -std=gnu99\ -static\ $*\ -lm
    endif
    if &filetype=="cpp"
        setlocal makeprg=g++\ '%'\ -o\ '%<'\ -g\ -O2\ -static\ -std=gnu++98\ $*
    endif
    make
endfunc

func! Run()
    let fout = expand("%<")
    if filereadable(fout)
        exec "!/home/sheng/.vim/run ./'%<'"
    endif
endfunc

func! Gdb()
    let fout = expand("%<")
    if filereadable(fout)
        exec "!/home/sheng/.vim/gdb ./'%<'"
    endif
endfunc

autocmd QuickFixCmdPost [^l]* nested cwindow 8
autocmd QuickFixCmdPost    l* nested lwindow 8


"-------------------------------------------------------------------------------

" encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

" Default Indentation
set autoindent
set smartindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
autocmd FileType c setlocal tabstop=8 shiftwidth=8 softtabstop=8
autocmd FileType cpp setlocal tabstop=8 shiftwidth=8 softtabstop=8
autocmd FileType txt setlocal tabstop=8 shiftwidth=8 softtabstop=8

" enable syntax hightlight and completion 
syntax enable
syntax on

" display settings
set number
set cursorline
set showmatch
set matchtime=2
set t_Co=256
set showcmd
set mouse=a
set nowrap
set scrolloff=2
set laststatus=2
set guifont=Monaco\ 13

if has("gui_running")
    color desert
    set go=aAce
    set columns=160
    set lines=48
endif

" search operations
set incsearch
set ignorecase
set smartcase
" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
            \ if ! exists("g:leave_my_cursor_position_alone") |
            \     if line("'\"") > 0 && line ("'\"") <= line("$") |
            \         exe "normal g'\"" |
            \     endif |
            \ endif
set confirm
set history=1000
set backspace=indent,eol,start

" copy and paste
vmap <c-x> "+x
vmap <c-c> "+y
nmap <c-v> "+gp
imap <c-v> <c-r>+
vmap <c-v> "+gP

" set color scheme
"let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

"-------------------------------------------------------------------------------------------------
" modify
" hilight function name
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2 
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cfunctions ctermfg=118 cterm=none
hi String ctermfg=185 cterm=none
hi PreProc ctermfg=197 cterm=none
hi Type gui=italic ctermfg=81 cterm=none 
hi Structure ctermfg=81 cterm=none
hi Macro ctermfg=81 cterm=bold
hi PreCondit ctermfg=81 cterm=bold
hi Label ctermfg=81 cterm=none
hi Keyword ctermfg=81 cterm=none
hi Operator ctermfg=81 cterm=none
hi Statement ctermfg=197 cterm=none
hi Tag ctermfg=185 cterm=none
hi Conditional term=underline  cterm=bold ctermfg=lightgreen  gui=bold  guifg=#60ff60
hi Repeat term=underline  cterm=bold ctermfg=lightgreen  gui=bold  guifg=#60ff60
hi Exception term=underline  cterm=bold ctermfg=lightgreen  gui=bold  guifg=#60ff60
hi Visual ctermbg=233 cterm=none
set cursorline 
hi CursorLine ctermbg=233 cterm=none
"--------------------------------------------------------------------------------------------------
"
"
""""""""""syntastic""""""""""""
let g:syntastic_check_on_open = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
"set error or warning signs
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
"whether to show balloons
let g:syntastic_enable_balloons = 1

""""""""""""YCM""""""""""""""""""""
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_collect_identifiers_from_tags_files = 1
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	
"回车即选中当前项
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> 
" 跳转到定义处
"""""""""""""""""""""""""""""""""""""""""

""""""""vimPowerline""""""""'
"if want to use fancy,need to add font patch -> git clone git://gist.github.com/1630581.git ~/.fonts/ttf-dejavu-powerline
"let g:Powerline_symbols = 'fancy'
let g:Powerline_symbols = 'unicode'
"'''''''''''''''''''''''''''''''''''''''''
"
source $VIMRUNTIME/mswin.vim

behave mswin


