let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
            \ 'name': 'annotate',
            \ }

function! s:unite_source.gather_candidates(args, context)
    let fname = expand('%')
    let annotate = s:annotate(fname)
    let lines = map(map(split(annotate, '\n'), 'split(v:val, ":")'), '[v:val[0] . ":" . v:val[1], v:val[0]]')

    return map(lines, '{
                \ "word": v:val[0],
                \ "source": "annotate",
                \ "kind": "annotate",
                \ "log": v:val[1],
                \ }')
endfunction

function! unite#sources#annotate#define()
    "call s:create_log()
    return s:unite_source
endfunction

function! s:annotate(fname)
    return system('ssh -p 1035 bz1.jasper-da.com "cd trunk;hg annotate ' . a:fname . '"')
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
