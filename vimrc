" No compatibility
set nocp                       "MAIS IMPORTANTE DE TUDO: FORA DO MODO DE COMPATIBILIDADE!!! SEMPRE USAR!!!"

" Plugin management ------------------------------------------------------------
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
Bundle 'scrooloose/syntastic'
Bundle 'dbakker/vim-lint'

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

" Vim Configuration ------------------------------------------------------------
set incsearch                  "busca incremental
set hlsearch                   "highlight da busca
set nostartofline              "deixa o cursor no lugar
set ruler                      "mostra o cursor o tempo todo
set showmatch                  "mostrar o par de: {} e ()
set expandtab                  "usar espaços e não tabs
set ignorecase                 "ignorar maiúsculas e minúsculas nas bucas
set smartcase                  "torna a busca case sensitive se houver uma letra maiúscula nela
set nowrap                     "sem wrap
set shiftwidth=4               "?
set softtabstop=4              "tabulação de 4 espaços
set tabstop=4                  "tabulacao de 4 espaços
set cindent                    "C style indentation
set t_Co=256                   "Use 16 colors
set showcmd                    "mostrar comando excutado.Ex:dd
set sidescroll=1               "Scroll caracter por caracter
set title                      "seta o titulo do terminal/aba para o nome do arquivo sendo editado
set backspace=indent,eol,start "Faz com que o backspace possa apagar coisas que nao foram escritas no ultimo insert
set splitright                 "Novo split aparece a direita
set splitbelow                 "Novo split aparece abaixo
set background=dark            "We will use a dark background
set wildmenu                   "Apresenta lista de opcoes na linha de comando
set wildignore=*.o,moc_*,Makefile,*.rej,*.orig "Ignore files terminated with this
set lazyredraw                 "Nao atualiza enquanto roda macros
set mouse=a                    "Adiciona suporte a mouse (move o cursor ao clicar)
set shell=/bin/bash\ -l        "Para aliases funcionarem
set iskeyword-=\.              "New delimiter
set iskeyword-=\(              "New delimiter
set iskeyword-=\)              "New delimiter
set iskeyword-=\_              "New delimiter
let mapleader = ","            "Remapping leader key

if exists("&cursorline")
    set cursorline             "destacar a linha do cursor
endif
if has("syntax") && (&t_Co > 2)
    syntax on
endif

if has("cscope")
    "see more at http://cscope.sourceforge.net/cscope_maps.vim
    set cscopetag "use cscope and ctags for ctrl-], :ta and vim -t
    set csto=0     "try to use cscope first
    set nocscopeverbose
    let db = system("pwd|cut -d '/' --fields=1,2,3,4")."/cscope.out"
    let db = substitute(db, "\n", "", "")
    exec 'cs add '.db
endif

" Move to last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
                   \| exe "normal! g`\"" | endif

" Syntax Highlighting
autocmd Filetype cpp source  ~/.vim/cpp-colors.vim
autocmd Filetype vim source  ~/.vim/vim-colors.vim
autocmd Filetype java source ~/.vim/java-colors.vim

" Indentacao para arquivos haskell
autocmd Filetype haskell set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" END - Vim Configuration ------------------------------------------------------

" Unite Configuration ----------------------------------------------------------
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
" END - Unite Configuration ---------------------------------------------------

" Syntastic Configuration------------------------------------------------------
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['vim','sh','tcl','tex'],
                           \ 'passive_filetypes': [] }
let g:syntastic_cpp_check_header = 1
let b:syntastic_cpp_cflags = ' -Icommon/include/util -Icommon/include/gui '   .
                            \' -Icommon/include/license -Icommon/include/io ' .
                            \'-I../../qt-include/Qt -I../../qt-include/QtGui'
" END - Syntastic Configuration ------------------------------------------------

" Functions -------------------------------------------------------------------
function! GetOposite()
   let fname = expand("%")
        echo fname
   let other = ""
   if fnamemodify(fname, ":e") == "cpp"
       let other = substitute(fname, ".cpp",".h", "")
   endif
   if fnamemodify(fname, ":e") == "cc"
       let other = substitute(fname, ".cc",".h", "")
   endif
   if fnamemodify(fname, ":e") == "h"
       let other = substitute(fname, ".h",".cpp", "")
       if filereadable(other)
           " Found!!!
       else
           let other = substitute(fname, ".h",".cc", "")
       endif
   endif
   if fnamemodify(fname, ":e") == "rej"
       let other = substitute(fname, ".rej","", "")
   endif
   return other
endfunction

function! TabeOposite()
   let fname = GetOposite()
   exec("tabe " . fname)
endfunction

function! SplitOposite()
   let fname = GetOposite()
   exec("vsplit " . fname)
endfunction

function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction

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
function! ExtractVariable()
	let expression = escape(getreg('"'), '/\')
    highlight RenameVariableGroup ctermfg=white cterm=standout
	let m = matchadd("RenameVariableGroup", expression)
    redraw
	let name = inputdialog("Input new variable name: ")
	if name != ""
        exec "normal! [["
		let startLine = line('.')
		exec "normal! %"
		let stopLine = line('.')
		exec "normal! %"
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
function! RenameVariable()
    let origLine = line('.')
	let expression = escape(getreg('"'), '/\')
    exec "normal! [["
    let startLine = line('.')
    exec "normal! %"
    let stopLine = line('.')
    exec "normal! %"
    exec ":" . origLine
    call multiple_cursors#find(startLine, stopLine, expression)
endfunction

function! CommentLine()
    exec "normal A" . " "
    while col('.') < 80
        exec "normal A" . "-"
    endwhile
endfunction

"See differences from original file (resets if file is saved)
command! DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis
              \ | wincmd p | diffthis | wincmd p
" Mappings --------------------------------------------------------------------

" Simple navigation/control
nmap ; :
inoremap jj <Esc>
nnoremap <Up> gk
nnoremap <Down> gj
" Selecionar bloco novamente depois de indentar
xnoremap < <gv
xnoremap > >gv
" Auto Completion
imap <Tab> <C-R>=SuperTab()<CR>
" Opening oposite file
nmap <s-t> :call TabeOposite()<CR>
nmap <s-s> :call SplitOposite()<CR>
" Paste with correct indentation
nmap <C-p> "+p`]a
" Fechamento automático de parênteses e afins"
imap { {}<left>
imap ( ()<left>
imap [ []<left>
" Y fica similar a C e D
nnoremap Y y$
" Limpar buffer de busca com Enter
nmap <CR> :silent :nohlsearch<CR>
" Refactoring
noremap <Leader>ev y:call ExtractVariable()<cr>
noremap <Leader>rv y:call RenameVariable()<cr>
" Debug
nnoremap <C-d> append(line('$'), 'qDebug() << '.'\"'.expand('%.:p').':'.(line('.')+1).'\";')
nnoremap <C-j> append(line('$'), 'System.out.println(\"'.expand('%.:p').':'.(line('.')+1).'\");')
nnoremap <s-j> append(line('$'), 'puts {'.expand('%.:p').':'.(line('.')+1).'}')
" Unite
nmap <c-f> :Unite file_mru file_rec -start-insert -buffer-name='files'<CR>
nmap <c-h> :Unite history/yank<CR>
nmap <c-b> :Unite buffer<CR>
nmap <c-c> :w!:SyntasticReset<CR>:SyntasticCheck<CR>
" Diff current file against last save
nnoremap <Leader>do :DiffOrig<cr>
nnoremap <leader>dc :q<cr>:diffoff<cr>:exe ":" . g:diffline<cr>
" Easy comments
nnoremap <Leader>l :call CommentLine()<cr>

" Abreviations ----------------------------------------------------------------
ab qdeb qDebug() << ;<Del><Left>
ab qDeb qDebug() << ;<Del><Left>
ab qdebug qDebug() << ;<Del><Left>
ab qDebug qDebug() << ;<Del><Left>
ab qdebug() qDebug() << ;<Del><Left>
ab qDebug() qDebug() << ;<Del><Left>
