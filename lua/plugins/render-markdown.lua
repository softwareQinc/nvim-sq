return {
   "MeanderingProgrammer/render-markdown.nvim",
   ft = { "markdown" },
   -- dependencies = {
   --    "nvim-treesitter/nvim-treesitter",
   --    "echasnovski/mini.nvim",
   -- }, -- mini.nvim
   -- dependencies = {
   --    "nvim-treesitter/nvim-treesitter",
   --    "echasnovski/mini.icons",
   -- }, -- standalone mini plugins
   dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
   }, -- nvim-web-devicons
   config = function()
      ---@module 'render-markdown
      ---@type render.md.UserConfig
      local opts = {
         code = {
            language_name = false,
         },
      }
      local render_markdown = require("render-markdown")
      render_markdown.setup(opts)
      render_markdown.disable()
   end,
}
