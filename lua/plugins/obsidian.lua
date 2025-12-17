return {
   "epwalsh/obsidian.nvim",
   version = "*", -- recommended, use latest release instead of latest commit
   lazy = true,
   -- ft = "markdown",
   -- Replace the above line with the one below if you only want to load
   -- obsidian.nvim for Markdown files in your vault
   event = {
      -- If you want to use the home shortcut '~' here you need to call
      -- 'vim.fn.expand'
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre "
         .. (vim.uv.fs_realpath(vim.fs.normalize("~/notes/obsidian")) or "/dev/null")
         .. "/**.md",
      "BufNewFile " .. (vim.uv.fs_realpath(
         vim.fs.normalize("~/notes/obsidian")
      ) or "/dev/null") .. "/**.md",
   },
   -- Required
   dependencies = { "nvim-lua/plenary.nvim" },
   init = function()
      local vaults_dir = vim.uv.fs_realpath(
         vim.fs.normalize("~/notes/obsidian")
      ) or "/dev/null"
      local function is_markdown_in_vault()
         local bufname = vim.api.nvim_buf_get_name(0)
         return bufname:match(vaults_dir .. "/.*%.md$")
      end
      local hl_groups = {
         -- The options are passed directly to `vim.api.nvim_set_hl()`.
         -- See `:help nvim_set_hl`.
         ObsidianTodo = { bold = true, fg = "#f78c6c" },
         ObsidianDone = { bold = true, fg = "#89ddff" },
         ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
         ObsidianTilde = { bold = true, fg = "#ff5370" },
         ObsidianImportant = { bold = true, fg = "#d73128" },
         ObsidianBullet = { bold = true, fg = "#89ddff" },
         ObsidianRefText = { underline = true, fg = "#c792ea" },
         ObsidianExtLinkIcon = { fg = "#c792ea" },
         ObsidianTag = { italic = true, fg = "#89ddff" },
         ObsidianBlockID = { italic = true, fg = "#89ddff" },
         ObsidianHighlightText = { bg = "#75662e" },
      }
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
         group = vim.api.nvim_create_augroup(
            "MarkdownObsidian",
            { clear = true }
         ),
         pattern = { vaults_dir .. "/**.md" },
         callback = function()
            vim.opt_local.conceallevel = 2
         end,
         desc = "Set conceallevel=2 for Obsidian Markdown buffers",
      })
      vim.api.nvim_create_autocmd({ "ColorScheme" }, {
         group = vim.api.nvim_create_augroup(
            "MarkdownObsidian",
            { clear = false }
         ),
         callback = function()
            if is_markdown_in_vault() then
               for group, opts in pairs(hl_groups) do
                  vim.api.nvim_set_hl(0, group, opts)
               end
            end
         end,
         desc = "Apply Obsidian highlights for Obsidian Markdown files in vault",
      })
   end,
   opts = {
      workspaces = {
         {
            name = "personal",
            path = "~/notes/obsidian/personal",
         },
         {
            name = "work",
            path = "~/notes/obsidian/work",
         },
      },
   },
}
