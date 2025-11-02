function! GitBranch() abort
  let l:branch = system('git branch --show-current 2>/dev/null')
  let l:branch = substitute(l:branch, '\n', '', 'g')

  if empty(l:branch)
    return ''
  endif
  return ' [git:' . l:branch . '] '
endfunction

" I don't care about the colours though really:
" https://stackoverflow.com/questions/48271865
let g:currentmode = {
  \ 'n'  : 'n',
  \ 'v'  : 'v',
  \ 'V'  : 'vl',
  \ "\<C-v>" : 'vb',
  \ 'i'  : 'i',
  \ 'R'  : 'r',
  \ 'Rv' : 'rv',
  \ 'c'  : 'c',
  \ 't'  : 'f',
  \}

set noshowmode

set laststatus=2
" Left align stuff
set stl=\ %m
set stl+=%{(g:currentmode[mode()]=='n')?'\ \ NORMAL\ ':''}
set stl+=%{(g:currentmode[mode()]=='i')?'\ \ INSERT\ ':''}
set stl+=%{(g:currentmode[mode()]=='r')?'\ \ REPLACE\ ':''}
set stl+=%{(g:currentmode[mode()]=='rv')?'\ \ V-REPLACE\ ':''}
set stl+=%{(g:currentmode[mode()]=='v')?'\ \ VISUAL\ ':''}
set stl+=%{(g:currentmode[mode()]=='vl')?'\ \ V-LINE\ ':''}
set stl+=%{(g:currentmode[mode()]=='vb')?'\ \ V-BLOCK\ ':''}
set stl+=%{(g:currentmode[mode()]=='c')?'\ \ COMMAND\ ':''}
set stl+=%{(g:currentmode[mode()]=='f')?'\ \ FINDER\ ':''}
set stl+=%#PmenuSel#
set stl+=\ %f
" Right align (uses %=)
set stl+=%=
set stl+=[ft:%Y]
set stl+=%{GitBranch()}
