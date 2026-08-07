---@type LazyPluginSpec
return {
   "ibhagwan/fzf-lua",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   ---@module "fzf-lua"
   ---@type fzf-lua.Config|{}
   ---@diagnostic disable: missing-fields
   opts = {
      keymap = {
         fzf = {
            -- Map <C-q> to select all items and press enter
            ["ctrl-q"] = "select-all+accept",
         },
      },
   },
   ---@diagnostic enable: missing-fields
   config = function(_, opts)
      local fzf = require("fzf-lua")
      fzf.setup(opts)
      fzf.register_ui_select()
   end,
}
