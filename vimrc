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
set backspace=indent,eol,start "Faz com que o backspace possa apagar coisas que nao foram escritas no ultimo insert
set splitright                 "Novo split aparece a direita
set splitbelow                 "Novo split aparece abaixo
set background=dark
set wildmenu                   "Apresenta lista de opcoes na linha de comando
set wildignore=*.o,moc_*,Makefile,*.rej,*.orig
set lazyredraw                 "Nao atualiza enquanto roda macros

" Plugin management ------------------------------------------------------------
filetype on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'guns/xterm-color-table.vim'
Bundle 'godlygeek/tabular'
"Bundle 'vim-scripts/refactor'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'tpope/vim-unimpaired'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'Shougo/unite.vim'

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

" Limpar buffer de busca"
nmap <s-f> :silent :nohlsearch<CR>


" Unite Configuration
call unite#custom#source('buffer,file,file_mru,file_rec', 'matchers', 'matcher_fuzzy')
call unite#custom#source('buffer,file,file_mru,file_rec', 'sorters', 'sorter_rank')
call unite#custom#source('file_rec', 'ignore_pattern', 
      \'\%(^\|/\)\.$\|\~$\|\.\%(o\|exe\|dll\|bak\|DS_Store\|zwc\|pyc\|sw[po]\|class\)$'.
      \'\|\%(^\|/\)\%(\.hg\|\.git\|\.bzr\|\.svn\|tags\%(-.*\)\?\)\%($\|/\)'.
      \'\|\.orig\|\.rej')
call unite#custom#default_action('file,file_rec,file_mru', 'tabopen')
call unite#custom#default_action('buffer', 'goto')
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_mru_limit = 10
let g:unite_source_file_mru_long_limit = 100

nmap <c-f> :Unite file_mru file_rec -start-insert -buffer-name='files'<CR>
nmap <c-h> :Unite history/yank<CR>
nmap <c-b> :Unite buffer<CR>
"nmap <c-c> :Unite output -buffer-name='command'<CR>
nmap <c-c> :Unite process -buffer-name='processes'<CR>

"source /Users/guisousa/repos/vim/unite/kinds/annotate.vim
"source /Users/guisousa/repos/vim/unite/sources/annotate.vim
"nmap <c-a> call UniteAnnotate()
"function! UniteAnnotate()
"    let ln = line(".")-1
"    execute "Unite annotate -select=" . ln
"endfunction

" Ideas
" - Use :Unite command to output shell command output
" - Use :Unite line/fast to display the lines of an annotate, then do
"   something to display the log
" - I got an error with :Unite undo. Try again.
" - Create a unite source with my favorite commands, then set the default
"   action to be ex, then I can execute the command.
" END - Unite Configuration

:function! GetOposite()
:   let fname = expand("%")
:        echo fname
:   let other = ""
:   if fnamemodify(fname, ":e") == "cpp"
:       let other = substitute(fname, ".cpp",".h", "")
:   endif
:   if fnamemodify(fname, ":e") == "cc"
:       let other = substitute(fname, ".cc",".h", "")
:   endif
:   if fnamemodify(fname, ":e") == "h"
:       let other = substitute(fname, ".h",".cpp", "")
:       if filereadable(other)
:           " Found!!!
:       else
:           let other = substitute(fname, ".h",".cc", "")
:       endif
:   endif
:   if fnamemodify(fname, ":e") == "rej"
:       let other = substitute(fname, ".rej","", "")
:   endif
:   return other
:endfunction

:function! TabeOposite()
:   let fname = GetOposite()
:   exec("tabe " . fname)
:endfunction
nmap <s-t> :call TabeOposite()<CR>

:function! SplitOposite()
:   let fname = GetOposite()
:   exec("vsplit " . fname)
:endfunction
nmap <s-s> :call SplitOposite()<CR>

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
"runtime ftplugin/man.vim

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
"au BufWritePost .vimrc so ~/.vimrc

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

" Put debug line bellow cursor
nnoremap <C-d> append(line('$'), 'qDebug() << '.'\"'.expand('%.:p').':'.(line('.')+1).'\";')
nnoremap <C-j> append(line('$'), 'System.out.println(\"'.expand('%.:p').':'.(line('.')+1).'\");')
nnoremap <s-j> append(line('$'), 'puts {'.expand('%.:p').':'.(line('.')+1).'}')

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
command! -complete=shellcmd -nargs=+ Shell call RunShellCommand(<q-args>)
function! RunShellCommand(cmdline)
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
    call RunShellCommand('hg annotate '.filename)
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
"noremap <c-f> y:call RenameVariableGuisousa2()<cr>
