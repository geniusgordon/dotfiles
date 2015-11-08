" General
syntax on
scriptencoding utf8

" Vim UI
set cursorline
set hlsearch

" Vim Format
set autoindent
set smartindent

set shiftwidth=4 "讓縮排是四格空白
set tabstop=4 "內縮是四個欄位
set softtabstop=4 "backspace可刪除tab

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

Plugin 'bling/vim-airline'
Plugin 'tpope/vim-commentary' " comment stuff
Plugin 'mattn/emmet-vim' " fast html
Plugin 'elzr/vim-json' " json hightlight
Plugin 'terryma/vim-multiple-cursors' " multiple cursors
Plugin 'airblade/vim-gitgutter' " git
Plugin 'othree/html5.vim' " html5
Plugin 'maksimr/vim-jsbeautify' " html, css, js beautify
Plugin 'sk1418/HowMuch' " calculator

call vundle#end()            " required
filetype plugin indent on    " required

