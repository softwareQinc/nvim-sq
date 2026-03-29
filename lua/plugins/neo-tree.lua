---@type LazyPluginSpec
return {
   "nvim-neo-tree/neo-tree.nvim",
   cmd = "Neotree",
   branch = "v3.x",
   dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
   },
}
