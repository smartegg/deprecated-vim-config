set nocompatible "avoid bugs from older version of vi
set nu "display the number of lines
let mapleader=","             " change the leader to be a comma vs slash
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype on

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



""" Search path for 'gf' command (e.g. open #include-d files)
set path+=/usr/include/c++/**
"
" Tags
"
" If I ever need to generate tags on the fly, I uncomment this:
set tags+=/usr/include/tags
set tags+=./tags


" se autoindent
"se undofile
"se undodir=~/.vimundo
se term=linux


" auto-closes preview window after you select what to auto-complete with
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"use "help clang-complete  in section 3" to  config advanced configs
let g:clang_complete_copen=1
let g:clang_periodic_quickfix=0
let g:clang_use_library=1
let g:clang_complete_auto=0
let g:clang_hl_errors=1
let g:clang_snippets_engine="clang_complete"
let g:clang_conceal_snippets=1
let g:clang_exec="clang"
let g:clang_library_path='/usr/local/lib'
let g:clang_auto_user_options="path, .clang_complete,gcc"  
let g:clang_snippets=1
let g:clang_auto_select=1
let g:clang_sort_algo="priority"
let g:clang_complete_macros=1
let g:clang_complete_patterns=0
"let g:clang_user_options=''
map <F2>  :call g:ClangUpdateQuickFix()<CR>

"just for convenient
""
map <F3> :wall<CR>
map <F4> :quitall<CR>
map <F5> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"
" NERDTree 
"
map <leader>n :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0

map <F12> :call MakeTag()<CR><CR>
func! MakeTag()
   exec ":wall"
   exec "!ctags -R  --sort=yes --c++-kinds=+p --fields=+ialS --extra=+q ."
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
" incremental search that highlights results
"
se incsearch
se hlsearch
set ignorecase
set smartcase
set showmatch
" Ctrl-c clears the highlight from the last search
nnoremap <C-c> :nohlsearch<CR><C-c>


"
" Smart in-line manpages with 'K' in command mode
"
fun! ReadMan()
  " Assign current word under cursor to a script variable:
  let s:man_word = expand('<cword>')
  " Open a new window:
  :exe ":wincmd n"
  " Read in the manpage for man_word (col -b is for formatting):
  :exe ":r!man  " . s:man_word . " | col -b"
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

" F4: Switch on/off TagList
"let Tlist_Show_One_File = 1 " Displaying tags for only one file~
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_Sort_Type = "order" " sort by order or name
let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
let Tlist_Compart_Format = 1 " Remove extra information and blank lines from  the taglist window.
let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_Close_On_Select = 1 " Close the taglist window when a file or tag  is selected.
let Tlist_Enable_Fold_Column = 0 " Don't Show the fold indicator column in the taglist window.
let Tlist_WinWidth = 40
" let Tlist_Ctags_Cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++'
"  " very slow, so I disable this
let Tlist_Process_File_Always = 1 " To use the :TlistShowTag and the :TlistShowPrototype commands without the taglist window and the taglist
"  menu, you should set this variable to 1. 
"  :TlistShowPrototype [filename] [linenumber]



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

colo desert
set t_Co=256


""super tab configuration
let g:SuperTabDefaultCompletionType = "<c-p>"
let g:SuperTabRetainCOmpletionType=2   

"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

""astyle config
function CodeFormat()
    let lineNum = line(".")
    if &filetype == 'c' || &filetype == 'cpp'
        exec "%!astyle --options=$HOME/.vim/astyle/.astylerc"
        echohl WarningMsg | echo "code formatting done" | echohl None
    else
        echohl WarningMsg | echo "unsupported file type: ".&filetype | echohl None
    endif
    exec lineNum
endfunc
map <S-F> <Esc>:call CodeFormat()<CR>


""below for python config
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd BufRead *.py nmap <F5> :!python %<CR>



""minibufexpl
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

""for python
set ofu=syntaxcomplete#Complete
autocmd FileType python runtime! autoload/pythoncomplete.vim
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"


""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window

" don't outdent hashes
" inoremap # #

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.


"""" Messages, Info, Status
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}


" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
set list

""tasklist  :  handles TODO and FIMME
map <leader>td <Plug>TaskList

""Gundo: view diff's in vim undo history
map <leader>g :GundoToggle<CR>

""pyflasks : real-time python compile
let g:pyflakes_use_quickfix = 1

"pep8 : for python jump
let g:pep8_map='<leader>8'

"rope
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>
"Ack
nmap <leader>a <Esc>:Ack!

map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>

""Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"run py.test's
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>


""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently 
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" PEP8
let g:pep8_map='<leader>8'

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
        project_base_dir = os.environ['VIRTUAL_ENV']
	sys.path.insert(0, project_base_dir)
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF


" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif


""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces 
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default

