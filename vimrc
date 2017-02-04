"" Niil Öhlins vimrc
runtime! archlinux.vim
runtime plugin/dragvisuals.vim

call pathogen#incubate()
exe pathogen#infect()

" low means that list tabs is not highlighted
let g:solarized_visibility="low"
colorscheme solarized
" colorscheme tomorrow
set background=dark

"set guifont=Inconsolata\ 17
set guifont=Droid\ Sans\ Mono\ 12

syntax enable
syntax on
filetype plugin indent on

" setlocal omnifunc=necoghc#omnifunc
set omnifunc=necoghc#omnifunc
set showcmd
set incsearch
set showmatch
set ignorecase
set smartcase
set smartindent
set autowrite
set number
set relativenumber
set backspace=2
set ruler
set showcmd
set cursorline
set clipboard=unnamed
set whichwrap+=<,>,[,],l,h
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
" set to have a permanent column
"set colorcolumn=80
call matchadd("ColorColumn", '\%81v', 100)

" handle tabs
let tabLength=4
execute "set tabstop=".tabLength
execute "set shiftwidth=".tabLength
execute "set softtabstop=".tabLength
command! TabL let tabLength=4| execute "set tabstop=".tabLength| execute "set shiftwidth=".tabLength| execute "set softtabstop=".tabLength

set expandtab

set listchars=trail:·,tab:›\ ,nbsp:~
set list

ab scr src

"Some remaps
"inoremap uh <Esc>
inoremap tn <Esc>

nnoremap Y y$

" nnoremap <C-D> ZZ
nnoremap v V
nnoremap V v
nnoremap p ]p
nnoremap P [P
" Makes so that indendation does not disappear when
" entering normal mode
inoremap <CR> <CR>a<BS>
inoremap <C-BS> <esc>hdbi
nnoremap o oa<BS>
nnoremap O Oa<BS>
" insert closing curly bracket after an opening
inoremap {<CR> {<CR>}<Esc>Oa<BS>
" move wrapped lines
nnoremap j gj
nnoremap k gk
" nnoremap <C-B>o <C-w><C-w>

" let mapleader = "\<space>"

nnoremap <leader>; :A<CR>

" Get haskell type
if expand("%:t") =~ "\.hs"
  nnoremap <leader>t _"zyiW:let @a=system('ghc -e ":l ' . @% . '" -e ":t ' . @z . '"')<CR>"aPdd:s/\[Char\]/String/g<CR>j
  " nnoremap <leader>t _"zyiW:let @a=system('ghc -e ":l ' . expand('%:t') . '" -e ":t ' . @z . '"')<CR>"aPdd:s/\[Char\]/String/g<CR>j

  inoremap <leader>main main :: IO ()<cr>main =
  nnoremap <leader>main imain :: IO ()<cr>main =

  inoremap <leader>fn <esc>0yEo<esc>pA =<esc>kA ::

  noremap <silent> <leader>ht :GhcModType<CR>
  noremap <silent> <leader>hh :GhcModTypeClear<CR>
  noremap <silent> <leader>hT :GhcModTypeInsert<CR>
  noremap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>:lopen<CR>
endif


set wildmenu
set wildmode=list:longest,full

nnoremap <silent> n n:call HLNext(0.07)<CR>
nnoremap <silent> N N:call HLNext(0.07)<CR>

" OR ELSE briefly hide everything except the match...
function! HLNext (blinktime)
    highlight BlackOnBlack ctermfg=black ctermbg=black
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let hide_pat = '\%<'.lnum.'l.'
            \ . '\|'
            \ . '\%'.lnum.'l\%<'.col.'v.'
            \ . '\|'
            \ . '\%'.lnum.'l\%>'.(col+matchlen-1).'v.'
            \ . '\|'
            \ . '\%>'.lnum.'l.'
    let ring = matchadd('BlackOnBlack', hide_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction


" Set cursor position to old spot
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe  "normal! g'\"" | endif
endif
"make it so that on saving. All trailing spaces are removed
autocmd BufWritePre * :%s/\s\+$//e


inoremap <C-c> <NOP>
inoremap <C-w> <NOP>

nnoremap <leader>* :vimgrep /<C-R><C-W>/ **/*.* <CR>
nnoremap <leader>n :cnext <cr>
nnoremap <leader>N :cprev <cr>

cabbrev %s OverCommandLine<cr>%s
cabbrev '<,'>s OverCommandLine<cr>'<,'>s

" "make so you can drag stuff in visual mode
" vnoremap  <expr>  H        DVB_Drag('left')
" vnoremap  <expr>  L        DVB_Drag('right')
" vnoremap  <expr>  J        DVB_Drag('down')
" vnoremap  <expr>  K        DVB_Drag('up')

inoremap <S-Down>  <esc>vj
inoremap <S-Up>    <esc>vk
inoremap <S-Left>  <esc>vl
inoremap <S-Right> <esc>vh
nnoremap <S-Down>  vj
nnoremap <S-Up>    vk
nnoremap <S-Left>  vl
nnoremap <S-Right> vh
vnoremap <S-Down>  j
vnoremap <S-Up>    k
vnoremap <S-Left>  l
vnoremap <S-Right> h

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

command! NT NERDTree
let NERDTreeIgnore = ['\.hi$', '\.o$', '\.dyn_hi$', '\.dyn_o$']
command! TL TlistToggle
command! W w
command! Wq wq
command! WQ wq


command! HTML inoremap > a<esc>r>F<lyef>aaa<esc>hr<lr/pa><esc>F<i
"to start taglist. run :TlistToggle

nnoremap <leader>u g~iw
inoremap <leader>u <esc>g~iwea
