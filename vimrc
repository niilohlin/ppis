runtime! debian.vim

if has("syntax")
  syntax on
endif

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if has("autocmd")
  filetype plugin indent on
endif

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set smartindent
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
" set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


" makes the solarized plugin work
" dark seems to spawn light and vice versa
syntax enable
set background=dark
colorscheme solarized
set clipboard=unnamed

imap hh <Esc>
imap <C-BS> <C-w>
set whichwrap+=<,>,[,]
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>
"
"noremap h <NOP>
"noremap j <NOP>
"noremap k <NOP>
"noremap l <NOP>

set list
set listchars=tab:›\  

set number
set relativenumber
set backspace=2
set nocompatible
set ruler
set showcmd
set colorcolumn=80

nnoremap v V
nnoremap V v
nnoremap p ]p
nnoremap P [p
nnoremap <C-i> i_<Esc>r

inoremap <C-k> <Esc>ddkPi
inoremap <C-j> <Esc>ddpi
nnoremap <C-k> ddkP
nnoremap <C-j> ddp
vnoremap <C-k> dkP
vnoremap <C-j> dp
 
" Fix so that it inserts a arbitrary character and removes it so that 
" the indentation is persistent
inoremap <CR> <CR>a<BS>
nnoremap o oa<BS>
nnoremap O Oa<BS>

vnoremap < <gv
vnoremap > >gv

function CommentUncomment()
	let fileName = expand("%:t")
	if fileName =~ "\.py" || fileName =~ "\.sh" || fileName =~ "\.rb"
		let comChr = '#'
	elseif fileName =~ "\.cpp"
		let comChr = '//'
    elseif fileName =~ "\.vim"
        let comChr = '" '
	else
		let comChr = ''
	endif

	execute "normal 0"
	execute "normal qc"
	if getline(".")[col(".") - 1: col('.') - 2 + strlen(comChr)] == comChr
		let i = 0
		while i < strlen(comChr)
			execute "normal x"
			let i += 1
		endwhile
	else
		execute "normal i".comChr
	endif
	execute "normal q"
	execute "'<,'> normal @c"
endfunction

vmap <C-h> :call CommentUncomment()<CR>

function! Mirror(dict)
	for [key, value] in items(a:dict)
		let a:dict[value] = key
	endfor
	return a:dict
endfunction

function S(number)
	return submatch(a:number)
endfunction
function! SwapWords(dict, ...)
	let words = keys(a:dict) + values(a:dict)
	let words = map(words, 'escape(v:val, "|")')
	if(a:0 == 1)
		let delimiter = a:1
	else
		let delimiter = '/'
	endif
	let pattern = '\v(' . join(words, '|') . ')'
	exe '%s' . delimiter . pattern . delimiter
				\ . '\=' . string(Mirror(a:dict)) . '[S(0)]'
				\ . delimiter. 'g'
endfunction

function! MakeTag()
" Copy the tag
	exe 'normal yiw' 
" Insert opening bracket
	exe 'normal i<'  
"Insert closing bracket
	exe 'normal Ea>'  
" Insert endb
	exe 'normal a</' 
" put tag and insert >
	exe 'normal pa>' 
" goto opening tag >
	exe 'normal F>'   
endfunction

nmap gt :call MakeTag()<CR>
nmap gT :call MakeTag()<CR>a<CR><Esc>k
"imap <C-o> <Esc>:call MakeTag()<CR>a

" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/
function! Stenography()
	inoremap prs ()
	inoremap prn (
	inoremap prt )
	inoremap brks []
	inoremap brkn [
	inoremap brkt ]
	inoremap crks {}
	inoremap crkn {
	inoremap crkt }
	inoremap ( <NOP>
	inoremap ) <NOP>
	inoremap [ <NOP>
	inoremap ] <NOP>
	inoremap { <NOP>
	inoremap } <NOP>
	inoremap cln :
	inoremap scln ;
	inoremap : <NOP>
	inoremap ; <NOP>
"	inoremap hrz |
	inoremap divby /
"	inoremap blsh \\
"	inoremap | <NOP>
"	inoremap / <NOP>
	inoremap \ <NOP>
	inoremap wht ?
	inoremap tams *
	inoremap snbl @
	inoremap @ <NOP>
	inoremap ? <NOP>
	inoremap * <NOP>
	inoremap plus +
	inoremap minus -
	inoremap + <NOP>
	inoremap - <NOP>
	inoremap eql =
	inoremap = <NOP>
	inoremap undl _
	inoremap _ <NOP>
	
	inoremap one 1
	inoremap two 2
	inoremap three 3
	inoremap four 4
	inoremap five 5
	inoremap six 6
	inoremap svn 7
	inoremap eit 8
	inoremap nine 9
	inoremap zro 0
	inoremap 1 <NOP>
	inoremap 2 <NOP>
	inoremap 3 <NOP>
	inoremap 4 <NOP>
	inoremap 5 <NOP>
	inoremap 6 <NOP>
	inoremap 7 <NOP>
	inoremap 8 <NOP>
	inoremap 9 <NOP>
	inoremap 0 <NOP>
	
	inoremap amersnd &
	inoremap prcnt %
	inoremap tilde ~
	inoremap dollar $
	inoremap htag #
	inoremap bng !
	inoremap btick `
	inoremap & <NOP>
	inoremap % <NOP>
	inoremap ~ <NOP>
	inoremap $ <NOP>
	inoremap # <NOP>
	inoremap ! <NOP>
	inoremap ` <NOP>
endfunction

" exe Stenography()

execute pathogen#infect()
