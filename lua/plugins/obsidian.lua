---@type LazyPluginSpec
return {
   "epwalsh/obsidian.nvim",
   dependencies = { "nvim-lua/plenary.nvim" },
   version = "*", -- recommended, use latest release instead of latest commit
   lazy = true,
   -- ft = "markdown",
   -- Replace the above line with the one below if you only want to load
   -- obsidian.nvim for Markdown files in your vault
   event = {
      -- If you want to use the $HOME shortcut '~' here you need to call
      -- 'vim.fn.expand'
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      "BufReadPre "
         .. require("core.util").resolve_path("~/notes/obsidian")
         .. "/**/*.md",
      "BufNewFile "
         .. require("core.util").resolve_path("~/notes/obsidian")
         .. "/**/*.md",
   },
   init = function()
      local util = require("core.util")
      local vaults_dir = util.resolve_path("~/notes/obsidian")
      local grp =
         vim.api.nvim_create_augroup("MarkdownObsidian", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
         group = grp,
         pattern = { vaults_dir .. "/**.md" },
         desc = "Set conceallevel=2 for Obsidian Markdown buffers",
         callback = function()
            vim.opt_local.conceallevel = 2
         end,
      })
   end,
   opts = {
      workspaces = {
         {
            name = "personal",
            path = require("core.util").resolve_path(
               "~/notes/obsidian/personal"
            ),
         },
         {
            name = "work",
            path = require("core.util").resolve_path("~/notes/obsidian/work"),
         },
      },
   },
}
