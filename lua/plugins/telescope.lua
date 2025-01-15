return {
   {
      "nvim-telescope/telescope.nvim",
      cmd = { "Telescope" },
      tag = "0.1.8",
      -- or, branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim" },
   },
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
