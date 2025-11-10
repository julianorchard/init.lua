" Creates a per-git-project ShaDa file at ~/.local/share/nvim/shada/HASH.shada
"
" debug: echo &shadafile
function! s:project_shada() abort
  let l:root = get(systemlist('git rev-parse --show-toplevel'), 0, getcwd())
  if empty(l:root)
    return stdpath('state') . '/shada/default.shada'
  endif

  let l:hash = sha256(l:root)
  return stdpath('state') . '/shada/' . l:hash . '.shada'
endfunction

let &shadafile = s:project_shada()
