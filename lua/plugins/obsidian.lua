---@type LazyPluginSpec
return {
   "epwalsh/obsidian.nvim",
   version = "*", -- recommended, use latest release instead of latest commit
   lazy = true,
   -- ft = "markdown",
   -- Replace the above line with the one below if you only want to load
   -- obsidian.nvim for Markdown files in your vault
   event = {
      -- If you want to use the home shortcut '~' here you need to call
      -- 'vim.fn.expand'
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      "BufReadPre "
         .. (vim.uv.fs_realpath(vim.fs.normalize("~/notes/obsidian")) or "/dev/null")
         .. "/**/*.md",
      "BufNewFile " .. (vim.uv.fs_realpath(
         vim.fs.normalize("~/notes/obsidian")
      ) or "/dev/null") .. "/**/*.md",
   },
   dependencies = { "nvim-lua/plenary.nvim" },
   init = function()
      local vaults_dir = vim.uv.fs_realpath(
         vim.fs.normalize("~/notes/obsidian")
      ) or "/dev/null"
      local grp =
         vim.api.nvim_create_augroup("MarkdownObsidian", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
         group = grp,
         pattern = { vaults_dir .. "/**.md" },
         callback = function()
            vim.opt_local.conceallevel = 2
         end,
         desc = "Set conceallevel=2 for Obsidian Markdown buffers",
      })
   end,
   opts = {
      workspaces = {
         {
            name = "personal",
            path = vim.fs.normalize("~/notes/obsidian/personal"),
         },
         {
            name = "work",
            path = vim.fs.normalize("~/notes/obsidian/work"),
         },
      },
   },
}
