let s:kind = {
            \ 'name': 'annotate',
            \ 'default_action': 'log',
            \ 'action_table': {},
            \ 'parents': 'common',
            \ }
let s:kind.action_table.log = {
            \ 'is_selectable': 1,
            \ 'description': 'Show changeset information',
            \ }
function! s:kind.action_table.log.func(candidates)
    if len(a:candidates) == 0
        echo "candidates must be only one"
        return
    endif
    call s:show_log(a:candidates[0].log)
endfunction

let s:kind.action_table.patch = {
            \ 'is_selectable': 1,
            \ 'description': 'Show changeset patch',
            \ }
function! s:kind.action_table.patch.func(candidates)
    if len(a:candidates) == 0
        echo "candidates must be only one"
        return
    endif
    call s:show_patch(a:candidates[0].log)
endfunction

function! s:show_log(version)
    call RunShellCommand('ssh -p 1035 bz1.jasper-da.com "cd trunk;hg log -r ' . a:version . '"')
endfunction

function! s:show_patch(version)
    call RunShellCommand('ssh -p 1035 bz1.jasper-da.com "cd trunk;hg log -r ' . a:version . ' -p"')
endfunction

function! unite#kinds#annotate#define()
    return s:kind
endfunction
