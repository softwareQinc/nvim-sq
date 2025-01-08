return {
   "jackMort/ChatGPT.nvim",
   cmd = {
      "ChatGPT",
      "ChatGPTRun",
      "ChatGPTActAs",
      "ChatGPTCompleteCode",
      "ChatGPTEditWithInstructions",
   },
   config = function()
      local home = vim.fn.expand("~")
      require("chatgpt").setup({
         -- api_key_cmd = "gpg --decrypt " .. home .. "/OpenAIkey.txt.gpg",
         api_key_cmd = "cat " .. home .. "/OpenAIkey.txt",
      })
   end,
   dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
   },
}
