let mapleader = ','

" Vundle 
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'L9' " Vim script library

Plugin 'scrooloose/nerdtree' " file explorer
Plugin 'ryanoasis/vim-devicons'
nmap <leader>t :NERDTreeToggle<CR>

Plugin 'Yggdroot/indentLine'
let g:indentLine_color_term = 239

Plugin 'tpope/vim-commentary' " comment stuff
Plugin 'airblade/vim-gitgutter' " git
Plugin 'tpope/vim-abolish' " fast manipulations

Plugin 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

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
" Plugin 'flowtype/vim-flow'

" others
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'wikitopian/hardmode'
Plugin 'sk1418/HowMuch'

call vundle#end()            " required
filetype plugin indent on    " required

" General
syntax on
scriptencoding utf8
set term=xterm-256color
set shell=/bin/bash
set backupcopy=yes
set omnifunc=syntaxcomplete#Complete

" Restore cursor
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" UI
colorscheme default
hi Comment cterm=italic
hi jsThis cterm=italic ctermfg=magenta
hi xmlAttrib cterm=italic ctermfg=green
hi VertSplit ctermfg=235 ctermbg=235
hi LineNr ctermfg=237
hi CursorLine cterm=none ctermbg=237
hi StatusLine cterm=reverse ctermfg=235 ctermbg=245
hi StatusLineNC ctermfg=235 ctermbg=237
hi NonText ctermfg=237 ctermbg=235
hi EndOfBuffer ctermfg=237 ctermbg=235
set nu
set hlsearch
set statusline=%=%P\ %f\ %m
set fillchars=vert:\ ,stl:\ ,stlnc:\ "
set laststatus=2

" Format
set autoindent
set smartindent

set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

" Key Binding
" Toggle highlight search
nmap <leader>/ :set hlsearch! hlsearch?<CR>

" Toggle paste mode
nmap <leader>p :set invpaste paste?<CR>

" File type specific
autocmd FileType make setlocal noexpandtab
autocmd FileType css set filetype:scss

let g:prettier#trailing_comma = 'all'
function SetupPrettier()
  execute 'set formatprg=prettier\ --stdin\ --single-quote\ --trailing-comma='.g:prettier#trailing_comma
endfunction
function TogglePrettierTrailingComma()
  let g:prettier#trailing_comma = g:prettier#trailing_comma == 'all' ? 'es5' : 'all'
  call SetupPrettier()
  echo 'prettier#trailing_comma:' g:prettier#trailing_comma
endfunction
autocmd FileType javascript call SetupPrettier()
nmap <leader>, :call TogglePrettierTrailingComma()<CR>

autocmd FileType python set formatprg=autopep8\ -

" map alt to  because termite is 7bit
set <M-f>=f
nmap <M-f> gggqG<C-o><C-o>
