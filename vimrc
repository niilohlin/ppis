" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
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

"imap hh <Esc>
"imap <C-BS> <C-w>
set whichwrap+=<,>,[,]
set tabstop=4
set shiftwidth=4
"set expandtab
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

nmap v V
nmap p ]p
nmap P [p
nmap <C-i> i_<Esc>r

imap <C-k> <Esc>ddkPi
imap <C-j> <Esc>ddpi
nmap <C-k> ddkP
nmap <C-j> ddp
vmap <C-k> dkP
vmap <C-j> dp

function CommentUncomment()
	let fileName = expand("%:t")
	if fileName =~ "\.py" || fileName =~ "\.sh" || fileName =~ "\.rb"
		let comChr = '#'
	elseif fileName =~ "\.cpp"
		let comChr = '//'
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
	exe 'normal %h'   
endfunction

nmap <C-o> :call MakeTag()<CR>
imap <C-o> <Esc>:call MakeTag()<CR>a

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

execute pathogen#infect()