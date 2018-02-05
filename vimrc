" No compatibility
set nocp                       "MAIS IMPORTANTE DE TUDO: FORA DO MODO DE COMPATIBILIDADE!!! SEMPRE USAR!!!"

" Plugin management ------------------------------------------------------------
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Plugin 'gmarik/vundle'

Plugin 'guns/xterm-color-table.vim'
Plugin 'godlygeek/tabular'
"Plugin 'vim-scripts/refactor'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'tpope/vim-unimpaired'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
" Matcher for CtrlP
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'JazzCore/ctrlp-cmatcher'
" These are text object extensions
Plugin 'kana/vim-textobj-user'
" iv/av for segments of camel case or snake case identifiers.
Plugin 'Julian/vim-textobj-variable-segment'
" i,/a, for elements of a parameter list.
Plugin 'sgur/vim-textobj-parameter'
Plugin 'junegunn/fzf.vim', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plugin 'sickill/vim-monokai'
" Highlight color names and codes
Plugin 'chrisbra/Colorizer'
Plugin 'tmux-plugins/vim-tmux'

filetype plugin indent on
 
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin command are not allowed..
" Plugin management - END ------------------------------------------------------

" Vim Configuration ------------------------------------------------------------
set incsearch                  "busca incremental
set hlsearch                   "highlight da busca
set nostartofline              "deixa o cursor no lugar
set nojoinspaces               "nao adiciona um espaco extra ao fazer join de linhas
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
set wildmenu                   "Apresenta lista de opcoes na linha de comando
set wildignore=*.o,moc_*,Makefile,*.rej,*.orig "Ignore files terminated with this
set lazyredraw                 "Nao atualiza enquanto roda macros
set mouse=a                    "Adiciona suporte a mouse (move o cursor ao clicar)
set shell=/bin/bash\ -l        "Para aliases funcionarem
set iskeyword-=\.              "New delimiter
set iskeyword-=\(              "New delimiter
set iskeyword-=\)              "New delimiter
set iskeyword-=\_              "New delimiter
colorscheme solarized          "Using dark solarized
set background=dark            "We will use a dark background
let mapleader = "\<Space>"     "Remapping leader key
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
" Workaround for using solarized over SSH from Iterm2.
" Colors are wrong, but it is bettern than whithout it.
if empty($DISPLAY)
    let g:solarized_termcolors=256
endif
if exists('$TMUX')
    set term=xterm-256color
    let g:solarized_termcolors=16
endif

if exists("&cursorline")
    set cursorline             "destacar a linha do cursor
endif
if has("syntax") && (&t_Co > 2)
    syntax on
endif

"let g:colorizer_auto_filetype='vim'

" Move to last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
                   \| exe "normal! g`\"" | endif

" Syntax Highlighting
"autocmd Filetype cpp source  ~/.vim/cpp-colors.vim
"autocmd Filetype vim source  ~/.vim/vim-colors.vim
"autocmd Filetype java source ~/.vim/java-colors.vim
"

autocmd Filetype tcl set iskeyword+=\_

" Indentacao para arquivos haskell
autocmd Filetype haskell set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" makefiles retain tabs (adding to your autocommand group)
autocmd filetype make setlocal ts=4 sts=4 sw=4 noexpandtab
" END - Vim Configuration ------------------------------------------------------

let os = substitute(system('uname'), "\n", "", "")

" ControlP Configuration ------------------------------------------------------
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files = 0
let g:ctrlp_working_path_mode = 'r'
"if os == "Linux"
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$|\.([od])$'
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.hg', '/depot/tool/201512/64/bin/hg --cwd %s locate -I .'],
            \ },
        \ 'fallback': 'find %s -type f'
        \ }
"else
"    let g:ctrlp_user_command = 'cat %s/.filelist'
"endif
if !has('python')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif
let g:ctrlp_by_filename = 1
"let g:ctrlp_match_func = { 'match': 'matcher#cmatch' }
"let g:ctrlp_lazy_update = 100
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
    if substitute(system('uname'), "\n", "", "") == "Darwin"
        echo "On iTerm2, hold down alt and select the text to copy."
    endif
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

function! DebugType()
    let fname = expand('%')
    if fnamemodify(fname, ":e") == "java"
        return "java"
    elseif fnamemodify(fname, ":e") == "tcl"
        return "tcl"
    elseif match(getline(1,'$'), "#include <QDebug>") >= 0
        return "qDebug"
    else
        return "cout"
    endif
endfunction

function! DebugSelection()
    let selection = GetVisualSelection()
    let debug = DebugType()
    if debug == "java"
        let @x = 'System.out.print("' . selection . ' = "); System.out.println(' . selection . ');'
    elseif debug == "qDebug"
        let @x = 'qDebug() << "' . selection . ' = " << (' . selection . ');'
    elseif debug == "cout"
        let @x = 'std::cout << "' . selection . ' = " << (' . selection . ') << std::endl;'
    endif
    normal o
    normal "xP
endfunction
function! GetVisualSelection()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction
vmap <Leader>d :call DebugSelection()<CR>
vmap <c-d> :call DebugSelection()<CR>

function! ToggleMouseSupport()
    if substitute(system('uname'), "\n", "", "") == "Darwin"
        echo "On iTerm2, hold down alt and select the text to copy."
    endif
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

function! OpenFileUnderCursorInSeparateTab()
    let l = line('.')
    let c = col('.')
    let save_cursor = getpos('.')
    exec ":tabe %"
    call setpos('.', save_cursor)
    normal gf
endfunction
" Mappings --------------------------------------------------------------------

" Basic Mappings ---------

" Simple navigation/control
nmap ; :
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
" Buffers And Tabs
nnoremap <CR> :bnext<CR>
nnoremap <backspace> :bprev<CR>
nnoremap <tab> gt
nnoremap <s-tab> gT
" Windows
nnoremap <s-up> :resize +1<CR>
nnoremap <s-down> :resize -1<CR>
nnoremap <s-right> :vertical resize +1<CR>
nnoremap <s-left> :vertical resize -1<CR>


" Helper Mappings ---------

" Open file in separate tab
nnoremap tgf :call OpenFileUnderCursorInSeparateTab()<CR>
" Opening oposite file
nmap <Leader>t :call TabeOposite()<CR>
nmap <Leader>s :call SplitOposite()<CR>
" File Name
nmap <Leader>n :echo expand("%")<CR>
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
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy/<C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy?<C-R><C-R>=substitute(
            \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>

" Debug
function! DebugLine()
    let debug = ""
    let fname = expand("%")
    if fnamemodify(fname, ":e") == "java"
        let debug = 'System.out.println("'.expand('%.:p').':'.(line('.')+1).'");'
    elseif fnamemodify(fname, ":e") == "tcl"
        let debug = 'puts {'.expand('%.:p').':'.(line('.')+1).'}'
    elseif match(getline(1,'$'), "#include <QDebug>") >= 0
        let debug = 'qDebug() << __FILE__ << ":" << __LINE__;'
    else
        let debug = 'std::cout << __FILE__ << ":" << __LINE__ << std::endl;'
    endif
    call append(line('.'), debug)
endfunction

nnoremap <C-d> :call DebugLine()<CR>

nnoremap <Leader>b o#include "/home/guisousa/tools/backtrace/backtrace.cpp"<CR>pretty_backtrace();<Esc>

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
":augroup Unite
":   autocmd!
":   let mapleader = "n"
":   nnoremap <Leader>f :Unite file_mru file_fixed -start-insert -buffer-name='files'<CR>
":   nnoremap <Leader>h :Unite history/yank<CR>
":   nnoremap <Leader>b :Unite buffer<CR>
":   let g:unite_sources_ssh = "ssh ..."
":   let g:unite_sources_files = "/Users/guisousa/mercurial_files"
":augroup END

" Abreviations ----------------------------------------------------------------
ab qdeb qDebug() << ;<Del><Left>
ab qDeb qDebug() << ;<Del><Left>
ab qdebug qDebug() << ;<Del><Left>
ab qDebug qDebug() << ;<Del><Left>
ab qdebug() qDebug() << ;<Del><Left>
ab qDebug() qDebug() << ;<Del><Left>
ab cout std::cout << << std::endl;<Esc>13hi

"  For lgb
"  let g:ctrlp_prompt_mappings = {
"    \ 'PrtBS()':              ['<bs>', '<c-]>'],
"    \ 'PrtDelete()':          ['<del>'],
"    \ 'PrtDeleteWord()':      ['<c-w>'],
"    \ 'PrtClear()':           ['<c-u>'],
"    \ 'PrtSelectMove("j")':   ['<c-j>', '<down>'],
"    \ 'PrtSelectMove("k")':   ['<c-k>', '<up>'],
"    \ 'PrtSelectMove("t")':   ['<Home>', '<kHome>'],
"    \ 'PrtSelectMove("b")':   ['<End>', '<kEnd>'],
"    \ 'PrtSelectMove("u")':   ['<PageUp>', '<kPageUp>'],
"    \ 'PrtSelectMove("d")':   ['<PageDown>', '<kPageDown>'],
"    \ 'PrtHistory(-1)':       ['<c-n>'],
"    \ 'PrtHistory(1)':        ['<c-p>'],
"    \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
"    \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>'],
"    \ 'AcceptSelection("t")': ['<s-t>'],
"    \ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>'],
"    \ 'ToggleFocus()':        ['<s-tab>'],
"    \ 'ToggleRegex()':        ['<c-r>'],
"    \ 'ToggleByFname()':      ['<c-d>'],
"    \ 'ToggleType(1)':        ['<c-f>', '<c-up>'],
"    \ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
"    \ 'PrtExpandDir()':       ['<tab>'],
"    \ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
"    \ 'PrtInsert()':          ['<c-\>'],
"    \ 'PrtCurStart()':        ['<c-a>'],
"    \ 'PrtCurEnd()':          ['<c-e>'],
"    \ 'PrtCurLeft()':         ['<c-h>', '<left>', '<c-^>'],
"    \ 'PrtCurRight()':        ['<c-l>', '<right>'],
"    \ 'PrtClearCache()':      ['<F5>'],
"    \ 'PrtDeleteEnt()':       ['<F7>'],
"    \ 'CreateNewFile()':      ['<c-y>'],
"    \ 'MarkToOpen()':         ['<c-z>'],
"    \ 'OpenMulti()':          ['<c-o>'],
"    \ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
"    \ }

" Experimental
function! FormatFunctionParameters()
    " First, set formatting option for function parameters
    setlocal cino=(0
    " Execute edditting
    execute "normal! f,a\n"
    set cino<
endfunction

nnoremap <leader>f :call FormatFunctionParameters()<CR>

function! FormatSelectedFunctionParameters()
    " First, set formatting option for function parameters
    setlocal cino=(0
    " Execute edditting
    '<,'>s/,/,\r/g
    execute "normal! '[=']"
    set cino<
endfunction

vnoremap <leader>f :call FormatSelectedFunctionParameters()<CR><CR>
