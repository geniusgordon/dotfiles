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
Plugin 'tpope/vim-abolish'

Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
set laststatus=2

" snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" html
Plugin 'othree/html5.vim' " html5
Plugin 'maksimr/vim-jsbeautify' " html, css, js beautify
Plugin 'mattn/emmet-vim' " fast html
Plugin 'briancollins/vim-jst' " ejs
Plugin 'jwalton512/vim-blade' " laravel blade

" css
Plugin 'hail2u/vim-css3-syntax'

" js
Plugin 'mxw/vim-jsx' " jsx
let g:jsx_ext_required = 0

Plugin 'pangloss/vim-javascript'
let g:javascript_plugin_flow = 1

Plugin 'elzr/vim-json'

" others
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'wikitopian/hardmode'
Plugin 'sk1418/HowMuch'

call vundle#end()            " required
filetype plugin indent on    " required

" General
syntax on
scriptencoding utf8
" Restore cursor
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
set shell=/bin/bash
" set backupcopy=yes

" UI
colorscheme default
" set cursorline
set hlsearch
highlight Comment cterm=italic
highlight Special cterm=italic ctermfg=magenta guifg=SlateBlue
highlight xmlAttrib cterm=italic ctermfg=green guifg=SeaGreen

" Format
set autoindent
set smartindent

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

" Key Binding
let mapleader = ','

" Toggle highlight search
nmap <leader>/ :set hlsearch! hlsearch?<CR>

" Toggle paste mode
nmap <leader>p :set invpaste paste?<CR>

" File type specific
autocmd FileType make setlocal noexpandtab
autocmd FileType css set filetype:scss
autocmd FileType javascript set formatprg=prettier\ --stdin\ --single-quote\ --trailing-comma=all
