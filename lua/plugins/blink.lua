---@type LazyPluginSpec
return {
   "Saghen/blink.cmp",
   dependencies = { "L3MON4D3/LuaSnip" },
   event = "VeryLazy",
   build = "cargo build --release",
   opts = {
      cmdline = { completion = { menu = { auto_show = true } } },
      completion = {
         menu = {
            border = "rounded",
            draw = {
               columns = {
                  { "label", "label_description", gap = 1 },
                  { "kind_icon", "kind", "source_name", gap = 1 }, -- Added "source_name" here
               },
            },
         },
         documentation = {
            auto_show = true,
            window = {
               border = "rounded",
            },
         },
      },
      fuzzy = { implementation = "prefer_rust" },
      keymap = { ["<CR>"] = { "accept", "fallback" } },
      signature = {
         enabled = true,
         window = { border = "rounded" },
      },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      snippets = { preset = "luasnip" },
   },
}
