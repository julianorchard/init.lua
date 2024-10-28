" https://vim.fandom.com/wiki/Increasing_or_decreasing_numbers
function! AddSubtract(char)
  let pattern = &nrformats =~# 'alpha' ? '[[:alpha:][:digit:]]' : '[[:digit:]]'
  call search(pattern, 'cw')
  execute 'norm! ' . v:count1 . a:char
endfunction

nnoremap <silent> <C-i> :<C-u>call AddSubtract("\<C-a>")<CR>
nnoremap <silent> <C-x> :<C-u>call AddSubtract("\<C-x>")<CR>
