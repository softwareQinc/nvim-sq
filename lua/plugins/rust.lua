---@type LazySpec
return {
   -- Rust language support
   {
      "rust-lang/rust.vim",
      ft = "rust",
      init = function()
         vim.g.rustfmt_autosave = 1
      end,
   },

   -- Rust tooling support
   {
      "simrat39/rust-tools.nvim",
      ft = "rust",
      dependencies = { "neovim/nvim-lspconfig" },
   },

   -- Rust crates.io dependency management
   {
      "saecki/crates.nvim",
      dependencies = { "hrsh7th/nvim-cmp" },
      ft = { "rust", "toml" },
      config =
         ---@param _ LazyPlugin
         ---@param opts table
         function(_, opts)
            local crates = require("crates")
            crates.setup(opts)
            crates.show()
            local grp = vim.api.nvim_create_augroup("Crates", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
               group = grp,
               pattern = { "rust" },
               callback =
                  ---@param ev vim.api.keyset.create_autocmd.callback_args
                  function(ev)
                     -- Buffer-local keymaps
                     local keymaps = require("core.keymaps")
                     local util = require("core.util")
                     util.map_keys(keymaps.rust, { buffer = ev.buf })
                  end,
               desc = "Keymaps rust (buffer-local)",
            })
         end,
   },
}
