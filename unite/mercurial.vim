let s:save_cpo = &cpo
set cpo&vim

let s:is_windows = unite#util#is_windows()

call unite#util#set_default('g:unite_source_file_ignore_pattern',
      \'\%(^\|/\)\.\.\?$\|\~$\|\.\%(o|exe|dll|bak|DS_Store|pyc|zwc|sw[po]\)$')

function! unite#sources#mercurial#define()
  "call s:create_log()
  return s:source_file
endfunction

let s:source_file = {
      \ 'name' : 'mercurial',
      \ 'description' : 'candidates from file list',
      \ 'ignore_pattern' : g:unite_source_file_ignore_pattern,
      \ 'default_kind' : 'file',
      \}

function! s:source_file.gather_candidates(args, context)
  let files = readfile('mercurial_files','',)

  let start      = 0
  let inc        = 50
  let candidates = []

  while start <= len(files)
    echo 'File searching...(press any key to cancel.) - ' . start . ' files found.'
    redraw
    if getchar(0)
      break
    endif

    let candidates += map(files[start : start + inc - 1],
        \ 'unite#sources#mercurial#create_file_dict(v:val, 1)')

    let start += inc
  endwhile
  redraw!

  return candidates
endfunction

function! s:source_file.complete(args, context, arglead, cmdline, cursorpos)
  return unite#sources#mercurial#complete_file(
        \ a:args, a:context, a:arglead, a:cmdline, a:cursorpos)
endfunction

function! unite#sources#mercurial#create_file_dict(file, is_relative_path, ...)
  let is_newfile = get(a:000, 0, 0)

  let dict = {
        \ 'word' : a:file, 'abbr' : a:file,
        \ 'action__path' : a:file,
        \}

  if a:is_relative_path
    let dict.action__path = unite#util#substitute_path_separator(
        \                    fnamemodify(a:file, ':p'))
  endif

  let dict.action__directory = fnamemodify(dict.action__path, ':h')

  let dict.kind = 'file'

  return dict
endfunction

function! unite#sources#mercurial#copy_files(dest, srcs)
  return unite#kinds#mercurial#do_action(a:srcs, a:dest, 'copy')
endfunction
function! unite#sources#mercurial#move_files(dest, srcs)
  return unite#kinds#mercurial#do_action(a:srcs, a:dest, 'move')
endfunction
function! unite#sources#mercurial#delete_files(srcs)
  return unite#kinds#mercurial#do_action(a:srcs, '', 'delete')
endfunction

function! s:get_filetime(filename)
  let filetime = getftime(a:filename)
  if !has('python3')
    return filetime
  endif

  if filetime < 0 && getftype(a:filename) !=# 'link'
    " Use python3 interface.
python3 <<END
import os
import os.path
import vim
os.stat_float_times(False)
try:
  ftime = os.path.getmtime(vim.eval(\
    'unite#util#iconv(a:filename, &encoding, "char")'))
except:
  ftime = -1
vim.command('let filetime = ' + str(ftime))
END
  endif

  return filetime
endfunction

function! s:log(args)
  let log = readfile('log')
  call writefile(log + [a:args], 'log')
endfunction

function! s:create_log()
  call writefile(['log guisousa'], 'log')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
