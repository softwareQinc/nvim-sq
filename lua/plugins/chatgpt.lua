---@type LazyPluginSpec
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
      local home_dir = vim.uv.os_homedir()
      -- local gpg_file_path
      local key_path
      if home_dir then
         -- gpg_file_path = vim.fn.fnameescape(home_dir) .. "/OpenAIkey.gpg"
         key_path = vim.fn.fnameescape(home_dir) .. "/OpenAIkey.txt"
      end
      local display_cmd
      if string.match(vim.uv.os_uname().sysname, "Windows") then
         display_cmd = "type " -- Windows
      else
         display_cmd = "cat " -- UNIX-like
      end
      require("chatgpt").setup({
         -- api_key_cmd = "gpg --decrypt " .. gpg_file_path
         api_key_cmd = display_cmd .. key_path,
      })
   end,
   dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
   },
}
