---@type LazySpec
return {
   -- Tree-sitter: LSP syntax tree and better syntax highlighting
   {
      "nvim-treesitter/nvim-treesitter",
      branch = "main",
      build = ":TSUpdate",
      config = function()
         local ts = require("nvim-treesitter")
         local parsers = {
            "c",
            "lua",
            "luadoc",
            "query",
            "vim",
            "vimdoc",
         }

         -- Replicate `ensure_installed`, runs asynchronously, skips existing
         -- languages
         ts.install(parsers)

         local available_parsers =
            require("nvim-treesitter.config").get_available()

         --- Check whether a Tree-sitter parser is available in the configured
         --- list
         ---@param lang string Tree-sitter language (e.g., 'lua', 'cpp')
         ---@return boolean True if the language exists in `available_parsers`
         local function parser_is_available(lang)
            return vim.tbl_contains(available_parsers, lang)
         end

         --- Attempt to register a Tree-sitter language.
         --- This calls `vim.treesitter.language.add()`, which returns `true`
         --- if the parser can be successfully loaded.
         ---@param lang string Tree-sitter language
         ---@return boolean? True if the parser is installed and loadable
         local function parser_is_installed(lang)
            return vim.treesitter.language.add(lang)
         end

         --- Enable Tree-sitter-based features for a buffer
         --- Replicates:
         ---  - `highlight = { enable = true }`
         ---  - `indent = { enable = true }`
         ---  - `fold = { enable = true }`
         ---@param buf integer Buffer handle (0 = current buffer)
         ---@param language string Tree-sitter language
         local function enable_treesitter_features(buf, language)
            -- Guard against race conditions: buffer may be deleted or not yet
            -- loaded
            if
               not vim.api.nvim_buf_is_valid(buf)
               or not vim.api.nvim_buf_is_loaded(buf)
            then
               return
            end

            -- Folding
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"

            -- Disable Tree-sitter highlighting for selected languages
            local disabled_ts_highlight = {
               latex = true, -- conflicts with `VimTeX`
            }

            -- Replicate `highlight = { enable = true }`
            if not disabled_ts_highlight[language] then
               vim.treesitter.start(buf, language)
            end

            -- Replicate `indent = { enable = true }`
            vim.bo[buf].indentexpr =
               "v:lua.require'nvim-treesitter'.indentexpr()"
         end

         local grp = vim.api.nvim_create_augroup("treesitter.setup", {})
         vim.api.nvim_create_autocmd("FileType", {
            group = grp,
            callback =
               ---@param args vim.api.keyset.create_autocmd.callback_args
               function(args)
                  local buf = args.buf
                  local filetype = args.match
                  local language = vim.treesitter.language.get_lang(filetype)
                     or filetype

                  if parser_is_available(language) then
                     ts.install(language)
                  else
                     return
                  end

                  local timer = vim.uv.new_timer() or {}
                  timer:start(
                     500,
                     500,
                     vim.schedule_wrap(function()
                        if parser_is_installed(language) then
                           enable_treesitter_features(buf, language)
                           timer:stop()
                           timer:close()
                        end
                     end)
                  )

                  -- Safety timeout: stop checking after 60 seconds
                  vim.defer_fn(function()
                     if timer:is_active() then
                        timer:stop()
                        timer:close()
                     end
                  end, 60000)
               end,
         })
      end,
   },

   -- Tree-sitter: Current code context
   {
      "nvim-treesitter/nvim-treesitter-context",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      event = "BufReadPost",
   },

   -- Tree-sitter: Text objects
   {
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      branch = "main",
      keys = require("core.keymaps").nvim_treesitter_textobjects,
      config = function()
         require("nvim-treesitter-textobjects").setup({
            -- Define your own text objects mappings similar to ip (inner
            -- paragraph) and ap (a paragraph)
            select = {
               -- Automatically jump forward to textobj, similar to
               -- `targets.vim`
               lookahead = true,
               -- You can choose the select mode (default is charwise 'v')
               --
               -- Can also be a function which gets passed a table with the keys
               -- * query_string: e.g., '@function.inner'
               -- * method: e.g., 'v' or 'o'
               -- and should return the mode ('v', 'V', or '<c-v>') or a table
               -- mapping query_strings to modes
               selection_modes = {
                  ["@parameter.outer"] = "v", -- charwise
                  ["@function.outer"] = "V", -- linewise
                  -- ['@class.outer'] = '<c-v>', -- blockwise
               },
               -- If you set this to `true` (default is `false`) then any
               -- textobject is extended to include preceding or succeeding
               -- whitespace. Succeeding whitespace has priority in order to
               -- act similarly to eg the built-in `ap`.
               --
               -- Can also be a function which gets passed a table with the keys
               -- * query_string: e.g., '@function.inner'
               -- * selection_mode: e.g., 'v'
               -- and should return true of false
               include_surrounding_whitespace = false,
            },

            -- Define your own mappings to jump to the next or previous text
            -- object. This is similar to ]m, [m, ]M, [M Neovim's mappings to
            -- jump to the next or previous function
            move = {
               -- Whether to set jumps in the jumplist
               set_jumps = true,
            },
         })
      end,
   },
}
