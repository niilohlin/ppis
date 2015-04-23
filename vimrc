
syntax enable
syntax on
filetype plugin indent on
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
"set colorcolumn=80
set clipboard=unnamed
set whichwrap+=<,>,[,],l,h

" handle tabs
let tabLength=4
execute "set tabstop=".tabLength
execute "set shiftwidth=".tabLength
execute "set softtabstop=".tabLength
set expandtab


set list
set listchars=tab:›\ 

" Some remaps
inoremap tn <Esc>
nnoremap v V
nnoremap V v
nnoremap p ]p
nnoremap P [P
" Makes so that indendation does not disappear when 
" entering normal mode
inoremap <CR> <CR>a<BS>
nnoremap o oa<BS>
nnoremap O Oa<BS>


" Set cursor position to old spot
if has("autocmd")                                                      
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe  "normal! g'\"" | endif 
endif


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

vnoremap <C-h> :call CommentUncomment()<CR>


