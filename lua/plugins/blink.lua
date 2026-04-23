---@type LazyPluginSpec
return {
   "Saghen/blink.cmp",
   branch = "v1",
   dependencies = { "L3MON4D3/LuaSnip" },
   event = { "InsertEnter", "CmdlineEnter" },
   build =
      ---@param plugin LazyPlugin
      function(plugin)
         -- Check if cargo is available
         if vim.fn.executable("cargo") == 1 then
            vim.notify(
               "[blink.cmp] Compiling Rust binary...",
               vim.log.levels.INFO
            )
            -- Run the build command inside the plugin directory
            local obj = vim.system(
               { "cargo", "build", "--release" },
               { cwd = plugin.dir }
            ):wait()
            -- Output build status
            if obj.code == 0 then
               vim.notify("[blink.cmp] Build complete.", vim.log.levels.INFO)
            else
               vim.notify(
                  ("[blink.cmp] Build failed:\n%s"):format(
                     obj.stderr or "No error output"
                  ),
                  vim.log.levels.ERROR,
                  { title = "blink.cmp" }
               )
            end
         end
      end,
   opts = {
      cmdline = { completion = { menu = { auto_show = true } } },
      completion = {
         menu = {
            border = "rounded",
            draw = {
               columns = {
                  { "label", "label_description", gap = 1 },
                  { "kind_icon", "kind", "source_name", gap = 1 },
               },
            },
         },
         documentation = {
            auto_show = true,
            window = {
               border = "rounded",
               scrollbar = true,
               winhighlight = table.concat({
                  "Normal:BlinkCmpMenu",
                  "NormalFloat:BlinkCmpMenu",
                  "FloatBorder:BlinkCmpMenuBorder",
                  "CursorLine:BlinkCmpDocCursorLine",
                  "Search:None",
               }, ","),
            },
         },
      },
      -- enabled = function()
      --    -- Disable auto-completion for certain file types
      --    local disabled_filetypes = {
      --       markdown = true,
      --       text = true,
      --    }
      --    return not disabled_filetypes[vim.bo.filetype]
      -- end,
      fuzzy = {
         implementation = vim.fn.executable("cargo") == 1 and "prefer_rust"
            or "lua",
      },
      keymap = { ["<CR>"] = { "accept", "fallback" } },
      signature = {
         enabled = true,
         window = { border = "rounded" },
      },
      snippets = { preset = "luasnip" },
   },
}
