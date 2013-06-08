set nocp                       "MAIS IMPORTANTE DE TUDO: FORA DO MODO DE COMPATIBILIDADE!!! SEMPRE USAR!!!"
set incsearch                  "busca incremental"
set hlsearch                   "highlight da busca"
set nostartofline              "deixa o cursor no lugar"
set ruler                      "mostra o cursor o tempo todo"
set showmatch                  "mostrar o par de: {} e ()"
set expandtab                  "usar espaços e não tabs"
set ignorecase                 "ignorar maiúsculas e minúsculas nas bucas"
set smartcase                  "torna a busca case sensitive se houver uma letra maiúscula nela
set nowrap                     "sem wrap"
set shiftwidth=4               "?"
set softtabstop=4              "tabulação de 4 espaços"
set tabstop=4                  "tabulacao de 4 espaços"
set cindent                    "indentação" estilo C"
set t_Co=256                   "Use 16 colors
set showcmd                    "mostrar comando excutado.Ex:dd"
set sidescroll=1               "Scroll caracter por caracter"
set title                      "seta o titulo do terminal/aba para o nome do arquivo sendo editado"

" Plugin management ------------------------------------------------------------
filetype on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'guns/xterm-color-table.vim'
Bundle 'godlygeek/tabular'
Bundle 'vim-scripts/refactor'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'tpope/vim-unimpaired'
Bundle 'terryma/vim-multiple-cursors'
"Bundle 'Rip-Rip/clang_complete'

filetype plugin indent on
 
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
" Plugin management - END ------------------------------------------------------

if exists("&cursorline")
    set cursorline                 "destacar a linha do cursor"
endif
if has('syntax') && (&t_Co > 2)
  syntax on
  filetype on
  filetype plugin on
  filetype indent on
endif

" Syntax Highlighting
autocmd Filetype cpp source  ~/.vim/cpp-colors.vim
autocmd Filetype vim source  ~/.vim/vim-colors.vim
autocmd Filetype java source ~/.vim/java-colors.vim

" Indentacao para arquivos haskell
autocmd Filetype haskell set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Navegar linhas visiveis
autocmd Filetype tex nnoremap <Up> gk
autocmd Filetype tex nnoremap <Down> gj

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p1 --fields=+iaS --extra=+q .<CR>

" Destacar palavra sob o cursor -> * e # fazem a mesma coisa
"nmap <C-f> :let @/="<C-r><C-w>"<CR>
" Limpar buffer de busca"
nmap <s-f> :silent :nohlsearch<CR>

:function! GetHeaderOrSource()
:   let fname = expand("%")
:        echo fname
:   if fnamemodify(fname, ":e") == "cpp"
:       exec("tabe " .substitute(fname, ".cpp",".h", ""))
:   endif
:   if fnamemodify(fname, ":e") == "h"
:       exec("tabe " .substitute(fname, ".h",".cpp", ""))
:   endif
:endfunction

nmap <s-h> :call GetHeaderOrSource()<CR>

:function! GetHeaderOrSourceToSplit()
:   let fname = expand("%")
:        echo fname
:   if fnamemodify(fname, ":e") == "cpp"
:       exec("vsplit " .substitute(fname, ".cpp",".h", ""))
:   endif
:   if fnamemodify(fname, ":e") == "h"
:       exec("vsplit " .substitute(fname, ".h",".cpp", ""))
:   endif
:endfunction

nmap <s-j> :call GetHeaderOrSourceToSplit()<CR>

:function! GetRejectedOrOrignal()
:   let fname = expand("%")
:        echo fname
:   if fnamemodify(fname, ":e") == "rej"
:       exec("tabe " .substitute(fname, ".rej","", ""))
:   else
:       exec("tabe " . fname . ".rej")
:   endif
:endfunction

nmap <s-r> :call GetRejectedOrOrignal()<CR>

" Paste with correct indentation
nmap <C-p> :p=`[<CR>

" para poupar keystrokes
nmap ; :

" Abreviations
ab qdeb qDebug() << ;<Del><Left>
ab qDeb qDebug() << ;<Del><Left>
ab qdebug qDebug() << ;<Del><Left>
ab qDebug qDebug() << ;<Del><Left>
ab qdebug() qDebug() << ;<Del><Left>
ab qDebug() qDebug() << ;<Del><Left>

" Fechamento automático de parênteses e afins"
imap { {}<left>
imap ( ()<left>
imap [ []<left>

" Y fica similar a C e D
nnoremap Y y$

" \K faz man da palavra sob o cursor
runtime ftplugin/man.vim

" Para aliases funcionarem
set shell=/bin/bash\ -l
nmap <f5> :call CompileLatex()<CR><CR>

function! CompileLatex()
    execute ":wa"
    execute ":!compileLatex ".expand("%")
endfunction
command! -nargs=1 C
            \ | execute ':silent !'.<q-args>
            \ | execute ':redraw!'

" Selecionar bloco novamente depois de indentar
vnoremap < <gv
vnoremap > >gv

inoremap jj <Esc>

" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" ex mode commands made easy
nnoremap ; :

" usar tab para autocompletar
function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction
imap <Tab> <C-R>=SuperTab()<CR>

" usar  . e ( e ) como delimitadores
set iskeyword-=\.
set iskeyword-=\(
set iskeyword-=\)

nnoremap <C-d> :put ='qDebug() << '.'\"'.expand('%.:p').':'.(line('.')+1).'\";'<CR>
nnoremap <C-j> :put ='System.out.println(\"'.expand('%.:p').':'.(line('.')+1).'\");'<CR>
nnoremap <s-j> :put ='puts {'.expand('%.:p').':'.(line('.')+1).'}'<CR>

if has("cscope")
    "see more at http://cscope.sourceforge.net/cscope_maps.vim
    set cscopetag "use cscope and ctags for ctrl-], :ta and vim -t
    set csto=0     "try to use cscope first
    set nocscopeverbose
    let db = system("pwd|cut -d '/' --fields=1,2,3,4")."/cscope.out"
    let db = substitute(db, "\n", "", "")
    exec 'cs add '.db

    "mappings
"    nmap <C-G> :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <Tab> :vert scs find g <C-R>=expand("<cword>")<CR><CR>
"    nmap <C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>
"    nmap <C-S>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
endif

" Executar comandos do shell com :Shell e mostrar resultados em novo buffer
"http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  "call setline(1, 'You entered:    ' . a:cmdline)
  "call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  "call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction


function! Annotate()
    let ln = line(".")+1
    let filename = expand("%")
    let filetype = &ft
    call s:RunShellCommand('hg annotate '.filename)
    execute 'silent '.ln
    execute 'set filetype='.filetype
endfunction
ca ann :call Annotate()<CR>

" Refactoring
" Depends on vim-scripts/refactor
function! RenameVariableGuisousa()
	let expression = escape(getreg('"'), '/\')
    highlight RenameVariableGroup ctermfg=white cterm=standout
	let m = matchadd("RenameVariableGroup", expression)
    redraw
	let name = inputdialog("Input new variable name: ")
	if name != ""
		call GotoBeginingBracketOfCurrentFunction()
		let startLine = line('.')
		exec "normal! %"
		let stopLine = line('.')
		call GotoBeginingBracketOfCurrentFunction()
        exec "/" . expression
		let firstLine = line('.')
		exec startLine . ',' . stopLine . ':s/\V\C' . expression . '/'. name .'/g'	
        exec ":" . firstLine
        exec "normal O" . name . " = "
        normal p
        normal A; 
        normal 0w
	endif
	call matchdelete(m)
endfunction

" Depends on terryma/vim-multiple-cursors
function! RenameVariableGuisousa2()
    let origLine = line('.')
	let expression = escape(getreg('"'), '/\')
    call GotoBeginingBracketOfCurrentFunction()
    let startLine = line('.')
    exec "normal! %"
    let stopLine = line('.')
    exec ":" . origLine
    call multiple_cursors#find(startLine, stopLine, expression)
endfunction

noremap <c-e> y:call RenameVariableGuisousa()<cr>
noremap <c-f> y:call RenameVariableGuisousa2()<cr>
