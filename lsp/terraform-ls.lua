return {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "tf" },
  root_markers = { ".git/", ".terraform/", "*.tf", "*.tfvars" },
  settings = {
    experimentalFeatures = {
      validateOnSave = true,
    },
  },
}
