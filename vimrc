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
"Bundle 'Shougo/vimproc'
"Bundle 'Shougo/unite.vim'
"Bundle 'Shougo/unite-outline'
"Bundle 'guisousa/unite-sources'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'Valloric/YouCompleteMe'

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
set t_Co=256                   "Use 256 colors
set ttyfast                    "terminal rapido
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
let mapleader = "\<Space>"     "Remapping leader key
colorscheme solarized          "Using dark solarized
"let g:solarized_termcolors=256 "If using default terminal colors, enable this option
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"

if exists("&cursorline")
    set cursorline             "destacar a linha do cursor
endif
if has("syntax") && (&t_Co > 2)
    syntax on
endif

" Move to last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
                   \| exe "normal! g`\"" | endif

" Syntax Highlighting
"autocmd Filetype cpp source  ~/.vim/cpp-colors.vim
"autocmd Filetype vim source  ~/.vim/vim-colors.vim
"autocmd Filetype java source ~/.vim/java-colors.vim

autocmd Filetype tcl set iskeyword+=\_

" Indentacao para arquivos haskell
autocmd Filetype haskell set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" makefiles retain tabs (adding to your autocommand group)
autocmd filetype make setlocal ts=4 sts=4 sw=4 noexpandtab
" END - Vim Configuration ------------------------------------------------------

" Unite Configuration ----------------------------------------------------------
"call unite#custom#source('buffer,file,file_mru,file_rec,file_fixed', 'matchers', 'matcher_fuzzy')
"call unite#custom#source('buffer,file,file_mru,file_rec,file_fixed', 'sorters', 'sorter_rank')
"call unite#custom#source('file_rec,file_fixed', 'ignore_pattern', 
"      \'\%(^\|/\)\.$\|\~$\|\.\%(o\|exe\|dll\|bak\|DS_Store\|zwc\|pyc\|sw[po]\|class\)$'.
"      \'\|\%(^\|/\)\%(\.hg\|\.git\|\.bzr\|\.svn\|tags\%(-.*\)\?\)\%($\|/\)'.
"      \'\|\.orig\|\.rej')
"call unite#custom#default_action('file,file_rec,file_mru,file_fixed', 'tabopen')
"call unite#custom#default_action('buffer', 'goto')
"let g:unite_source_history_yank_enable = 1
"let g:unite_source_file_mru_limit = 10
"let g:unite_source_file_mru_long_limit = 100
" END - Unite Configuration ---------------------------------------------------

" ControlP Configuration ------------------------------------------------------
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
"unlet g:ctrlp_custom_ignore
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v([\/]\.(git|hg|svn)$|dox\/|proofengine\/|external\/|COM\/|lib\/|frontend\/|Safelogic\/|bin\/|ap\/|common\/include\/)',
\ 'file': '\v.(hs|.*ignore|m4|txt|defines|smv|vhd|py|db|png|xpm|vhdl|y|l|d|dll|lib|pdf|dsp|dsw|a|m|out|raw|standalone|tex|eps|.*sh|make|gif|cfg)$',
\ }
" END - ControlP Configuration ------------------------------------------------

" Functions -------------------------------------------------------------------
function! GetOposite()
   let fname = expand("%")
        echo fname
   let other = ""
   if fnamemodify(fname, ":e") == "cpp"
       let other = substitute(fname, ".cpp$",".h", "")
   endif
   if fnamemodify(fname, ":e") == "cc"
       let other = substitute(fname, ".cc$",".h", "")
   endif
   if fnamemodify(fname, ":e") == "h"
       let other = substitute(fname, ".h$",".cpp", "")
       if filereadable(other)
           " Found!!!
       else
           let other = substitute(fname, ".h$",".cc", "")
       endif
   endif
   if fnamemodify(fname, ":e") == "rej"
       let other = substitute(fname, ".rej$","", "")
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

function! ToggleMouseSupport()
    let mouseSupport = getbufvar(1, "&mouse")
	if mouseSupport == ""
        let mouseSupport = "a"
    else
        let mouseSupport = ""
    endif
    exec "set mouse=" . mouseSupport
endfunction

"See differences from original file (resets if file is saved)
command! DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis
              \ | wincmd p | diffthis | wincmd p
" Mappings --------------------------------------------------------------------

" Basic Mappings ---------

" Simple navigation/control
nmap ; :
inoremap jj <Esc>
nnoremap <Up> gk
nnoremap <Down> gj
" Y fica similar a C e D
nnoremap Y y$
" Selecionar bloco novamente depois de indentar
xnoremap < <gv
xnoremap > >gv
" Fechamento automático de parênteses e afins"
imap { {}<left>
imap ( ()<left>
imap [ []<left>
" Paste with correct indentation
nmap <C-p> "+p`]a

" Helper Mappings ---------

" Opening oposite file
nmap <Leader>t :call TabeOposite()<CR>
nmap <Leader>s :call SplitOposite()<CR>
" Limpar buffer de busca com ,/
nnoremap <Leader>/ :silent :nohlsearch<CR>
" Refactoring
noremap <Leader>ev y:call ExtractVariable()<cr>
noremap <Leader>rv y:call RenameVariable()<cr>
" Diff current file against last save
nnoremap <Leader>do :DiffOrig<cr>
nnoremap <leader>dc :q<cr>:diffoff<cr>:exe ":" . g:diffline<cr>
" Easy comments
nnoremap <Leader>l :call CommentLine()<cr>
" Mouse support
nnoremap <Leader>m :call ToggleMouseSupport()<CR>
" Debug
nnoremap <C-d> :call append(line('.'), 'qDebug() << "'.expand('%.:p').':'.(line('.')+1).'";')<CR>
nnoremap <C-j> :call append(line('.'), 'System.out.println("'.expand('%.:p').':'.(line('.')+1).'");')<CR>
nnoremap <s-j> :call append(line('.'), 'puts {'.expand('%.:p').':'.(line('.')+1).'}')<CR>

" Fix for Iterm2
if &term=="xterm-256color"
    map <Esc>Oq 1
    map <Esc>Or 2
    map <Esc>Os 3
    map <Esc>Ot 4
    map <Esc>Ou 5
    map <Esc>Ov 6
    map <Esc>Ow 7
    map <Esc>Ox 8
    map <Esc>Oy 9
    map <Esc>Op 0
    map <Esc>On .
    map <Esc>OQ /
    map <Esc>OR *
    map <Esc>Ol +
    map <Esc>OS -
    map <Esc>OX =
    map! <Esc>Oq 1
    map! <Esc>Or 2
    map! <Esc>Os 3
    map! <Esc>Ot 4
    map! <Esc>Ou 5
    map! <Esc>Ov 6
    map! <Esc>Ow 7
    map! <Esc>Ox 8
    map! <Esc>Oy 9
    map! <Esc>Op 0
    map! <Esc>On .
    map! <Esc>OQ /
    map! <Esc>OR *
    map! <Esc>Ol +
    map! <Esc>OS -
    map! <Esc>OX =
endif

" YouCompleteMe ---------------------------------------------------------------
let g:ycm_confirm_extra_conf = 0
let mapleader = "y"            "Remapping leader key
:augroup YouCompleteMe
:   autocmd!
:   autocmd Filetype cpp nnoremap <Leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>
:   autocmd Filetype cpp nnoremap <Leader><F5> :YcmForceCompileAndDiagnostics<CR>
:augroup END
" END - YouCompleteMe ---------------------------------------------------------
" Unite
:augroup Unite
:   autocmd!
:   let mapleader = "n"
:   nnoremap <Leader>f :Unite file_mru file_fixed -start-insert -buffer-name='files'<CR>
:   nnoremap <Leader>h :Unite history/yank<CR>
:   nnoremap <Leader>b :Unite buffer<CR>
:   let g:unite_sources_ssh = "ssh ..."
:   let g:unite_sources_files = "/Users/guisousa/mercurial_files"
:augroup END

" Abreviations ----------------------------------------------------------------
ab qdeb qDebug() << ;<Del><Left>
ab qDeb qDebug() << ;<Del><Left>
ab qdebug qDebug() << ;<Del><Left>
ab qDebug qDebug() << ;<Del><Left>
ab qdebug() qDebug() << ;<Del><Left>
ab qDebug() qDebug() << ;<Del><Left>
