return {
   "folke/trouble.nvim",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   opts = {
      -- focus = true,
   },
   cmd = "Trouble",
   keys = require("core.keymaps").trouble.keys,
}
