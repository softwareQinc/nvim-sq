return {
   "nvim-pack/nvim-spectre",
   cmd = { "Spectre" },
   config = function()
      -- prevent sed from creating backup files (filename-E) on macOS
      if vim.loop.os_uname().sysname == "Darwin" then
         require("spectre").setup({
            replace_engine = {
               ["sed"] = {
                  cmd = "sed",
                  args = { "-i", "", "-E" },
               },
            },
         })
      end
   end,
}
