---@type LazyPluginSpec
return {
   "nvim-pack/nvim-spectre",
   cmd = { "Spectre" },
   config = function()
      -- Prevent sed from creating backup files (filename-E) on macOS and BSD
      local os_name = vim.uv.os_uname().sysname
      if os_name == "Darwin" or string.match(os_name, "BSD") then
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
