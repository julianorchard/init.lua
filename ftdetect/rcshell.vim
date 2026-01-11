" vint: -ProhibitAutocmdWithNoGroup
au BufRead,BufNewFile *.rc setfiletype rcshell

function! s:DetectRcShell()
  let shebang = getline(1)
  if shebang =~# '\(/\|\s\)rc$'
      set filetype=rcshell
  endif
endfunction

au BufRead,BufNewFile * call s:DetectRcShell()
