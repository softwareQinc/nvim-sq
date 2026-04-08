---@type LazySpec
return {
   -- Rust tooling support
   {
      "mrcjkb/rustaceanvim",
      version = "*",
      -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
      -- No need for lazy.nvim to lazy-load it.
      lazy = false,
      config = function()
         local grp =
            vim.api.nvim_create_augroup("Rustaceanvim", { clear = true })
         vim.api.nvim_create_autocmd("FileType", {
            group = grp,
            pattern = { "rust" },
            desc = "Keymaps Rust rustaceanvim (buffer-local)",
            callback =
               ---@param ev vim.api.keyset.create_autocmd.callback_args
               function(ev)
                  -- Buffer-local keymaps
                  local keymaps = require("core.keymaps")
                  local util = require("core.util")
                  util.map_keys(keymaps.rust_rustaceanvim, { buffer = ev.buf })
               end,
         })
      end,
   },

   -- Rust crates.io dependency management
   {
      "saecki/crates.nvim",
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
               pattern = { "rust", "toml" },
               desc = "Keymaps Rust crates.nvim (buffer-local)",
               callback =
                  ---@param ev vim.api.keyset.create_autocmd.callback_args
                  function(ev)
                     -- Buffer-local keymaps
                     local keymaps = require("core.keymaps")
                     local util = require("core.util")
                     util.map_keys(
                        keymaps.rust_crates_nvim,
                        { buffer = ev.buf }
                     )
                  end,
            })
         end,
   },
}
