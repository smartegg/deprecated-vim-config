set nocompatible "avoid bugs from older version of vi
set nu "display the number of lines
call pathogen#infect()
call pathogen#helptags()
se nobackup
se directory=~/.vim/swp,.
se shiftwidth=4
se sts=4
se modelines=2
se modeline
se nocp
"ref from "http://stevelosh.com/blog/2010/09/coming-home-to-vim/"
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
"set relativenumber

colorscheme evening
if has("autocmd")
    filetype on
    filetype indent on
    filetype plugin on
endif
syntax on


map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80
"set list
"set listchars=tab:▸\ ,eol:¬


"
" Search path for 'gf' command (e.g. open #include-d files)
"
set path+=/usr/include/c++/**

"
" Tags
"
" If I ever need to generate tags on the fly, I uncomment this:
" map <C-F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
set tags+=/usr/include/tags
set tags+=./tags


" se autoindent
se undofile
se undodir=~/.vimundo
se term=linux
"map <ESC>OP <F1>


"
" necessary for using libclang
"
let g:clang_library_path='/usr/lib/llvm-3.0/lib'
" auto-closes preview window after you select what to auto-complete with
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"use "help clang-complete  in section 3" to  config advanced configs
let g:clang_complete_copen=1
let g:clang_periodic_quickfix=0
map <F2>  :call g:ClangUpdateQuickFix()<CR>

"
"just for convenient
""
map <F3> :wall<CR>
map <F4> :quitall<CR>
map <F5> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"
" maps NERDTree to F10
"
nmap <silent> <F10> :NERDTreeToggle<CR>
" tells NERDTree to use ASCII chars
let g:NERDTreeDirArrows=0

map <F12> :call MakeTag()<CR><CR>
func! MakeTag()
   exec ":wall"
   exec "!ctags -R . --sort=yes --c++-kinds=+p --fields=+ialS --extra=+q"
   exec "!cscope -Rbq"
   cs add cscope.out
endfunc

"
" Better TAB completion for files (like the shell)
"
if has("wildmenu")
    set wildmenu
    set wildmode=longest,list
    " Ignore stuff (for TAB autocompletion)
    set wildignore+=*.a,*.o
    set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
    set wildignore+=.DS_Store,.git,.hg,.svn
    set wildignore+=*~,*.swp,*.tmp
endif


"
" Python stuff
"
" obsolete, replaced by flake8
" PEP8
"let g:pep8_map='<leader>8'

" ignore 'too long lines'
"let g:flake8_ignore="E501,E225"



"
" incremental search that highlights results
"
se incsearch
se hlsearch
set ignorecase
set smartcase
set showmatch
" Ctrl-L clears the highlight from the last search
nnoremap <C-l> :nohlsearch<CR><C-l>


"
" Smart in-line manpages with 'K' in command mode
"
fun! ReadMan()
  " Assign current word under cursor to a script variable:
  let s:man_word = expand('<cword>')
  " Open a new window:
  :exe ":wincmd n"
  " Read in the manpage for man_word (col -b is for formatting):
  :exe ":r!man 2 " . s:man_word . " | col -b"
  " Goto first line...
  :exe ":goto"
  " and delete it:
  :exe ":delete"
  " finally set file type to 'man':
  :exe ":set filetype=man"
  " lines set to 20
  :resize 20
endfun
" Map the K key to the ReadMan function: 
" with X to close it.
map K :call ReadMan()<CR>
nnoremap X :bd!<CR>

"
" Toggle TagList window with F8
"
nnoremap <silent> <F8> :TlistToggle<CR>

"
" Fix insert-mode cursor keys in FreeBSD
"
if has("unix")
  let myosuname = system("uname")
  if myosuname == "FreeBSD"
    set term=cons25
  endif
endif

" Taglist
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Auto_Update = 1
let Tlist_Close_On_Select = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1

"cscope configuration
if has("cscope")
	set cscopequickfix=s-,c-,d-,i-,t-,e-
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
	    cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
	    cs add $CSCOPE_DB
	endif
	set csverb
	map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
	map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
endif

