-- C, C++
---@type vim.lsp.Config
return {
   cmd = {
      "clangd",
      "--header-insertion=never",
      "--offset-encoding=utf-16",
   },
}
