augroup tf
  silent! autocmd! filetypedetect BufRead,BufNewFile *.tf
  autocmd BufRead,BufNewFile *.hcl,*.tfbackend set filetype=hcl
  autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl
  autocmd BufRead,BufNewFile *.tf,*.tfvars,*.tftest.hcl set filetype=terraform
  autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json
augroup END
