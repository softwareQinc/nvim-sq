-- Julia
---@type vim.lsp.Config
return {
   cmd = {
      "julia",
      "--project=@nvim-lspconfig",
      "-e",
      "using LanguageServer; using SymbolServer; runserver()",
   },
   filetypes = { "julia" },
}
