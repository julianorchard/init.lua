setlocal nowrap
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

setlocal spell

if has('EasyAlign')
" <leader>\ to align a table!
  vn <leader><Bslash> :EasyAlign*<Bar><Enter>
en
