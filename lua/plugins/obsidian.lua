return {
   "epwalsh/obsidian.nvim",
   version = "*", -- recommended, use latest release instead of latest commit
   lazy = true,
   -- ft = "markdown",
   -- Replace the above line with the one below if you only want to load
   -- obsidian.nvim for Markdown files in your vault
   event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre "
         .. (vim.loop.fs_realpath(vim.fs.normalize("~/obsidian_vaults")) or "/dev/null")
         .. "/**.md",
      "BufNewFile " .. (vim.loop.fs_realpath(vim.fs.normalize("~/obsidian_vaults")) or "/dev/null") .. "/**.md",
   },
   dependencies = {
      -- Required
      "nvim-lua/plenary.nvim",
   },
   init = function()
      local vaults_dir = vim.loop.fs_realpath(vim.fs.normalize("~/obsidian_vaults")) or "/dev/null"
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
         group = vim.api.nvim_create_augroup("Markdown", { clear = true }),
         pattern = vaults_dir .. "/**.md",
         command = "setlocal conceallevel=2",
      })
   end,
   opts = {
      workspaces = {
         {
            name = "personal",
            path = "~/obsidian_vaults/personal",
         },
         {
            name = "work",
            path = "~/obsidian_vaults/work",
         },
      },
   },
}
