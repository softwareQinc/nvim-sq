-- Go
return {
   cmd = { "gopls" },
   filetypes = { "go", "gomod", "gowork", "gotmpl" },
   root_markers = { "go.work", "go.mod", ".git" },
   settings = {
      gopls = {
         completeUnimported = true,
         usePlaceholders = true,
         analyses = { unusedparams = true },
         hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
         },
      },
   },
}
