return {
   "iamcco/markdown-preview.nvim",
   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
   ft = { "markdown" },
   build = "cd app && npx -y yarn install",
   init = function()
      vim.g.mkdp_filetypes = { "markdown" }
   end,
}
