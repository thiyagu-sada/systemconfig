set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
set bs=2				" allow backspacing over everything in insert mode
set ai					" always set autoindenting on
set nobackup			" keep a backup file
set writebackup 		"delete the backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
						" than 50 lines of registers
set history=50			" keep 50 lines of command line history
set ruler				" show the cursor position all the time
set incsearch			" for search 
set ts=4				" to set tab spacing to 4
set shiftwidth=4 		"to set shiftwidth to 4
set showmatch   		" to show the matching character
set smartindent 		" indent the lines w.r.t to braces
set ignorecase  		" ignore cases when searching
set smartcase   		" do uppercase search only if its given search string
set laststatus=2 		"show filename in the vim window
"set syntax=on
set mouse=a
set modifiable
set guioptions-=T
set guioptions-=m
set guioptions+=c
set guifont=Consolas:h10:cANSI
set cursorline
"set encoding=utf-8
set directory=.,$TEMP
behave mswin

" Don't use Ex mode, use Q for formatting
map Q gq
map <F5> :e<CR>G
map <F6> \be
map v<F6> \bv
map s<F6> \bs
map <F7> :execute "grep -ir ".expand("<cword>")." *"<CR>


if has("autocmd")
	autocmd FileType java call Settings_for_java()
endif


set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"functions from java.lang will be highlighted
let java_highlight_java_lang_ids=1
"will set syntax for functions
let java_highlight_functions="style"
"System.out and System.err statements are highlighted
let java_highlight_debug=1

"Settings only for java files.
function Settings_for_java()
	" abbrevations
	ab So System.out.println("
	ab Se System.err.println("
	ab pst printStackTrace();
	ab psvm public static void main(String[] args)
endfunction
