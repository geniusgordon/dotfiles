let mapleader = ','

" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'L9' " Vim script library

Plugin 'w0rp/ale' " Asynchronous Lint Engine

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
let g:limelight_conceal_ctermfg = 'gray'

Plugin 'flowtype/vim-flow'
let g:flow#autoclose = 1

" Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/IndexedSearch'
Plugin 'tpope/vim-commentary' " comment
Plugin 'airblade/vim-gitgutter' " git indicator
Plugin 'tpope/vim-fugitive' " git commands
Plugin 'tpope/vim-abolish' " fast manipulations
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'wikitopian/hardmode'
Plugin 'sk1418/HowMuch'

Plugin 'junegunn/limelight.vim'
let g:limelight_conceal_ctermfg = 239

Plugin 'junegunn/goyo.vim' " distraction-free writing
nmap <leader>g :Goyo<CR>
let g:goyo_height = '100%'
au! User GoyoEnter nested call <SID>goyo_enter()
au! User GoyoLeave nested call <SID>goyo_leave()
function! s:goyo_enter()
  hi StatusLineNC ctermfg=white
  set nu
  set so=999
  Limelight
endfunction
function! s:goyo_leave()
  set so=5
  so ~/.vim/colors.vim
  so ~/.vim/statusline.vim
  Limelight!
endfunction

Plugin 'reedes/vim-pencil'
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

Plugin 'scrooloose/nerdtree' " file explorer
" Plugin 'ryanoasis/vim-devicons'

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
let g:NERDTreeHighlightFoldersFullName = 1

Plugin 'Xuyuanp/nerdtree-git-plugin'
nmap <leader>t :NERDTreeToggle<CR>
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Staged"    : "+",
    \ "Untracked" : "*",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "x",
    \ "Dirty"     : "*",
    \ "Clean"     : "",
    \ 'Ignored'   : "",
    \ "Unknown"   : "?"
    \ }

Plugin 'Yggdroot/indentLine'
let g:indentLine_color_term = 239

Plugin 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <C-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

call vundle#end()            " required
filetype plugin indent on    " required

" General
syntax on
scriptencoding utf8
set term=xterm-256color
set shell=/bin/bash
set backupcopy=yes
set omnifunc=syntaxcomplete#Complete
setlocal foldmethod=syntax
set foldlevelstart=99

" Restore cursor
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" UI
set nu
set hlsearch
set cursorline
set so=5

" Format
set autoindent
set smartindent

" Tab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

" Key Binding
" Toggle highlight search
nmap <leader>/ :set hlsearch! hlsearch?<CR>

" Toggle paste mode
nmap <leader>p :set invpaste paste?<CR>

" Syntax highlighting group used at the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" File type specific
au FileType make setlocal noexpandtab
au FileType css set filetype:scss

source ~/.vim/format.vim
source ~/.vim/colors.vim
source ~/.vim/statusline.vim
