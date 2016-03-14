" General
syntax on
scriptencoding utf8
" 回到上次的那行
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Vim UI
set cursorline
set hlsearch

" Vim Format
set autoindent
set smartindent

set shiftwidth=2 "讓縮排是四格空白
set tabstop=2 "內縮是四個欄位
set softtabstop=2 "backspace可刪除tab
set expandtab

" Key Binding
let mapleader = ','

" Toggle highlight search
nmap <leader>/ :set hlsearch! hlsearch?<CR>

" Toggle paste mode
nmap <leader>p :set invpaste paste?<CR>

" Vundle 
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'L9' " Vim script library

Plugin 'scrooloose/nerdtree' " file explorer
nmap <leader>t :NERDTreeToggle<CR>

Plugin 'tpope/vim-commentary' " comment stuff
Plugin 'mattn/emmet-vim' " fast html
Plugin 'terryma/vim-multiple-cursors' " multiple cursors
Plugin 'sk1418/HowMuch' " calculator
Plugin 'airblade/vim-gitgutter' " git
Plugin 'othree/html5.vim' " html5
Plugin 'maksimr/vim-jsbeautify' " html, css, js beautify
Plugin 'cakebaker/scss-syntax.vim' " scss highlight
Plugin 'mxw/vim-jsx' " jsx highlight
Plugin 'othree/yajs.vim' " es6 highlight
Plugin 'elzr/vim-json' " json hightlight
Plugin 'briancollins/vim-jst' " ejs highlight

call vundle#end()            " required
filetype plugin indent on    " required

