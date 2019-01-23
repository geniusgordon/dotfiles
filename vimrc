let mapleader = ','

call plug#begin('~/.vim/plugged')

Plug 'VundleVim/Vundle.vim'

Plug 'w0rp/ale' " Asynchronous Lint Engine
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_set_loclist = 1
let g:ale_linters = {
    \ 'java': ['google-java-format'],
    \ 'kotlin': ['ktlint']
    \ }

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" html
Plug 'othree/html5.vim' " html5
Plug 'mattn/emmet-vim' " fast html

Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" css
Plug 'hail2u/vim-css3-syntax'

" js
Plug 'mxw/vim-jsx' " jsx
let g:jsx_ext_required = 0

Plug 'pangloss/vim-javascript'
let g:javascript_plugin_flow = 1

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'flowtype/vim-flow'
let g:flow#autoclose = 1

Plug 'jparise/vim-graphql'
Plug 'prettier/vim-prettier'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'avoid'

Plug 'fatih/vim-go'

Plug 'udalov/kotlin-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'peterhoeg/vim-qml'
Plug 'hsanson/vim-android'
let g:android_sdk_path = '/opt/android-sdk'

Plug 'vim-scripts/IndexedSearch'
Plug 'airblade/vim-gitgutter' " git indicator
Plug 'tpope/vim-commentary' " comment
Plug 'tpope/vim-fugitive' " git commands
Plug 'tpope/vim-abolish' " fast manipulations
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim' " adds various text objects
Plug 'andymass/vim-matchup' " better % navigation
Plug 'sk1418/HowMuch'

" Plug 'junegunn/limelight.vim'
" let g:limelight_conceal_ctermfg = 239

Plug 'junegunn/goyo.vim' " distraction-free writing
nmap <leader>g :Goyo<CR>
let g:goyo_width = 83
let g:goyo_height = '100%'
let g:goyo_linenr = 1
au! User GoyoEnter nested call <SID>goyo_enter()
au! User GoyoLeave nested call <SID>goyo_leave()
function! s:goyo_enter()
  hi StatusLineNC ctermfg=white
  set so=999
  GitGutterEnable
  " Limelight
endfunction
function! s:goyo_leave()
  set so=5
  so ~/.vim/colors.vim
  so ~/.vim/statusline.vim
  " Limelight!
endfunction

Plug 'reedes/vim-pencil'
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" file explorer
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let NERDTreeQuitOnOpen = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
let g:NERDTreeHighlightFoldersFullName = 1

Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
nmap <leader>t :NERDTreeToggle<CR>
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Staged"    : "+",
    \ "Untracked" : "*",
    \ "Renamed"   : " ",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "x",
    \ "Dirty"     : "*",
    \ "Clean"     : " ",
    \ 'Ignored'   : " ",
    \ "Unknown"   : "?"
    \ }

Plug 'junegunn/fzf.vim'
nmap <c-p> :FZF<CR>

Plug 'Yggdroot/indentLine'
let g:indentLine_color_term = 239
let g:indentLine_concealcursor = 0

Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1

nnoremap <C-w>h :TmuxNavigateLeft<cr>
nnoremap <C-w>j :TmuxNavigateDown<cr>
nnoremap <C-w>k :TmuxNavigateUp<cr>
nnoremap <C-w>l :TmuxNavigateRight<cr>
nnoremap <C-w>/ :TmuxNavigatePrevious<cr>

Plug 'yssl/QFEnter'

call plug#end()

" General
syntax on
set fenc=utf8
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
au BufRead /tmp/neomutt-* set tw=72

source ~/.vim/format.vim
source ~/.vim/colors.vim
source ~/.vim/statusline.vim

" echo highlight group under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" open quickfix after grep
augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END
