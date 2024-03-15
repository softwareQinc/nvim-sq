return {
   "hedyhli/outline.nvim",
   lazy = true,
   cmd = { "Outline", "OutlineOpen" },
   keys = require("core.keymaps").outline.keys,
   config = function()
      require("outline").setup({})
   end,
}
