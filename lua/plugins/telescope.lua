---@type LazySpec
return {
   -- Fuzzy finder and picker UI (files, grep, buffers, etc.)
   {
      "nvim-telescope/telescope.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
         -- Optional but recommended
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
         },
         -- Use Telescope as the UI for vim.ui.select / vim.ui.input
         "nvim-telescope/telescope-ui-select.nvim",
      },
      version = "*",
      cmd = { "Telescope" },
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

         -- To get fzf loaded and working with telescope, you need to call
         -- load_extension, somewhere after setup function:
         require("telescope").load_extension("fzf")
         require("telescope").load_extension("ui-select")
      end,
   },
}
