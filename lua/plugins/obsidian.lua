return {
   "epwalsh/obsidian.nvim",
   version = "*", -- recommended, use latest release instead of latest commit
   lazy = true,
   -- ft = "markdown",
   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
   event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre "
         .. vim.fn.expand("~")
         .. "/vaults/**.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/vaults/**.md",
   },
   dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
   },
   init = function()
      local home = vim.fn.expand("~")
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
         group = vim.api.nvim_create_augroup("Markdown", { clear = true }),
         pattern = home .. "/vaults/**.md",
         command = "setlocal conceallevel=2",
      })
   end,
   opts = {
      workspaces = {
         {
            name = "personal",
            path = "~/vaults/personal",
         },
         {
            name = "work",
            path = "~/vaults/work",
         },
      },
   },
}
