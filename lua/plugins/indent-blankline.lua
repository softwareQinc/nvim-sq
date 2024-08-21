return {
   "lukas-reineke/indent-blankline.nvim",
   event = { "BufReadPost", "BufNewFile" },
   main = "ibl",
   -- https://askubuntu.com/questions/1489149/custom-config-of-a-lua-plugin-in-neovim
   opts = {
      -- indent = { char = "│", highlight = highlight },
      -- scope = { enabled = false },
      indent = { char = "│" },
      scope = { enabled = true },
      whitespace = { highlight = { "Whitespace", "NonText" } },
      exclude = { filetypes = { "dashboard" } },
   },
}
