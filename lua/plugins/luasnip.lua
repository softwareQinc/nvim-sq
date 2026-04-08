---@type LazyPluginSpec
return {
   "L3MON4D3/LuaSnip",
   dependencies = { "rafamadriz/friendly-snippets" },
   version = "*",
   event = "InsertEnter",
   config = function()
      require("luasnip").setup({
         history = true,
         updateevents = "TextChanged,TextChangedI",
      })
      -- VSCode style snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      -- Custom Lua snippets
      local config_path = vim.fn.stdpath("config")
      require("luasnip.loaders.from_lua").load({
         paths = { config_path .. "/lua/snippets" },
      })
   end,
   -- Install jsregexp (optional!)
   build = "make install_jsregexp",
}
