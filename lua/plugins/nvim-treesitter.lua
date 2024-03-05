return {
   {
      -- LSP syntax tree and better syntax highlighting
      "nvim-treesitter/nvim-treesitter",
      event = { "BufReadPost", "BufNewFile" },
      cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
      build = ":TSUpdate",
      config = function()
         local configs = require("nvim-treesitter.configs")
         configs.setup({
            ensure_installed = {
               "lua",
               "luadoc",
               "c",
               "vim",
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            highlight = {
               enable = true,
               disable = {
                  "markdown",
               },
            },

            indent = {
               enable = true,
               -- disable = {
               --   "python",
               -- },
            },

            incremental_selection = {
               enable = true,
               keymaps = {
                  init_selection = "<leader>ss",
                  node_incremental = "<leader>si",
                  scope_incremental = "<leader>sc",
                  node_decremental = "<leader>sd",
               },
            },

            modules = {},
            ignore_install = {},
         })
      end,
   },
   -- Current code context
   {
      "nvim-treesitter/nvim-treesitter-context",
      event = { "BufReadPost", "BufNewFile" },
   },
}
