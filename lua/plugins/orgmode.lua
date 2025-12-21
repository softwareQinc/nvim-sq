return {
   "nvim-orgmode/orgmode",
   ft = { "org" },
   opts = {
      org_agenda_files = vim.fs.normalize("~/notes/org/**/*"),
      org_default_notes_file = vim.fs.normalize("~/notes/org/refile.org"),
   },
   -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~
   -- option, add ~org~ to ignore_install
   -- require('nvim-treesitter.configs').setup({
   --   ensure_installed = 'all',
   --   ignore_install = { 'org' },
   -- })
}
