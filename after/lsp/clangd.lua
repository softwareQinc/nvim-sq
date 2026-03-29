-- C, C++
---@type vim.lsp.Config
return {
   cmd = {
      "clangd",
      "--clang-tidy",
      "--header-insertion=never",
      "--offset-encoding=utf-16",
   },
}
