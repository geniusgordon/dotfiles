" General
syntax on
scriptencoding utf8
" 回到上次的那行
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
set shell=/bin/bash
" set backupcopy=yes

" Vim UI
set cursorline
set hlsearch

" Vim Format
set autoindent
set smartindent

set shiftwidth=2 "讓縮排是兩個格空白
set tabstop=2 "內縮是兩個欄位
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
Plugin 'airblade/vim-gitgutter' " git

" html
Plugin 'othree/html5.vim' " html5
Plugin 'maksimr/vim-jsbeautify' " html, css, js beautify
Plugin 'mattn/emmet-vim' " fast html
Plugin 'briancollins/vim-jst' " ejs highlight
Plugin 'jwalton512/vim-blade' " laravel blade

" css
Plugin 'hail2u/vim-css3-syntax'

" js
Plugin 'mxw/vim-jsx' " jsx highlight
Plugin 'othree/yajs.vim' " es6 highlight
Plugin 'othree/es.next.syntax.vim'
Plugin 'elzr/vim-json'

" others
Plugin 'ekalinin/Dockerfile.vim'

call vundle#end()            " required
filetype plugin indent on    " required

autocmd FileType make setlocal noexpandtab
autocmd FileType css set filetype:scss
let g:jsx_ext_required = 0

