---@type LazySpec
return {
   -- Fuzzy finder and picker UI (files, grep, buffers, etc.)
   {
      "nvim-telescope/telescope.nvim",
      version = "*",
      cmd = { "Telescope" },
      dependencies = {
         "nvim-lua/plenary.nvim",
         -- Optional but recommended
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
         },
      },
      config = function()
         -- To get fzf loaded and working with telescope, you need to call
         -- load_extension, somewhere after setup function:
         require("telescope").load_extension("fzf")
      end,
   },

   -- Use Telescope as the UI for vim.ui.select / vim.ui.input
   {
      "nvim-telescope/telescope-ui-select.nvim",
      event = "LspAttach",
      config = function()
         require("telescope").setup({
            extensions = {
               ["ui-select"] = {
                  require("telescope.themes").get_dropdown({}),
               },
            },
            pickers = {
               buffers = {
                  ignore_current_buffer = false,
                  sort_lastused = true,
               },
            },
         })
         require("telescope").load_extension("ui-select")
      end,
   },
}
