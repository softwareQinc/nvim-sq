return {
   -- Tree-sitter: LSP syntax tree and better syntax highlighting
   {
      "nvim-treesitter/nvim-treesitter",
      event = { "BufReadPost", "BufNewFile" },
      cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
      build = ":TSUpdate",
      config = function()
         local configs = require("nvim-treesitter.configs")
         configs.setup({
            ensure_installed = {
               "c",
               "lua",
               "luadoc",
               "query",
               "vim",
               "norg",
            },

            -- Install parsers synchronously (only applied to
            -- `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI
            -- installed locally
            auto_install = true,

            highlight = {
               enable = true,
               disable = {
                  "latex",
                  "markdown",
                  "tmux",
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
               keymaps = require("core.keymaps").nvim_treesitter.keymaps,
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
      dependencies = { "nvim-treesitter/nvim-treesitter" },
   },
}
