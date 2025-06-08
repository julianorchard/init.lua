" https://go.dev/doc/effective_go#formatting
" "Go has no line length limit. Don't worry about overflowing a punched card.
"  If a line feels too long, wrap it and indent with an extra tab."
setlocal colorcolumn="80"
" Ignoring that, 80 it is!

" Indentation
setlocal noexpandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4

if g:custom_conceal
  setlocal conceallevel=2
end
