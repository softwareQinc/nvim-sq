-- Key bindings

local M = {}

------------------------------------------------------------------------------
-- Global key bindings
M.generic = {
   n = {
      ["<leader>|"] = { "<cmd> vsplit <CR>", { desc = "Split vertically" } },
      ["<leader>-"] = { "<cmd> split <CR>", { desc = "Split horizontally" } },
      ["<leader>q"] = { "<cmd> bd <CR>", { desc = "Close current buffer" } },
      -- https://vi.stackexchange.com/a/3877
      ["<leader>o"] = { 'o<ESC>0"_D', { desc = "Insert new line below" } },
      ["<leader>O"] = { 'O<ESC>0"_D', { desc = "Insert new line above" } },
      --
      ["<ESC>"] = { "<cmd> nohlsearch <CR>" },

      ["<Up>"] = { "<Nop>" },
      ["<Down>"] = { "<Nop>" },
      ["<Left>"] = { "<Nop>" },
      ["<Right>"] = { "<Nop>" },
   },
   i = {
      ["<Up>"] = { "<Nop>" },
      ["<Down>"] = { "<Nop>" },
      ["<Left>"] = { "<Nop>" },
      ["<Right>"] = { "<Nop>" },
   },
   v = {
      ["<Up>"] = { "<Nop>" },
      ["<Down>"] = { "<Nop>" },
      ["<Left>"] = { "<Nop>" },
      ["<Right>"] = { "<Nop>" },
   },
}

M.tmux_navigator = {
   n = {
      ["<C-h>"] = { "<cmd> TmuxNavigateLeft <CR>", { desc = "Window left" } },
      ["<C-l>"] = { "<cmd> TmuxNavigateRight <CR>", { desc = "Window right" } },
      ["<C-j>"] = { "<cmd> TmuxNavigateDown <CR>", { desc = "Window down" } },
      ["<C-k>"] = { "<cmd> TmuxNavigateUp <CR>", { desc = "Window up" } },
   },
}

M.netrw = {
   n = {
      ["<leader>e"] = { "<cmd> Lexplore 15 <CR>", { desc = "NetRw toggle" } },
   },
}

M.neo_tree = {
   n = {
      ["<leader>n"] = { "<cmd> Neotree toggle <CR>", { desc = "Neo-tree toggle" } },
   },
}

M.telescope = {
   n = {
      ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", { desc = "Telescope files" } },
      ["<leader>fa"] = {
         "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
         { desc = "Telescope all files" },
      },
      ["<leader>fn"] = {
         "<cmd> lua require('telescope.builtin').find_files{cwd=vim.fn.stdpath 'config'} <CR>",
         { desc = "Telescope Neovim config files" },
      },
      ["<leader>fg"] = { "<cmd> Telescope live_grep <CR>", { desc = "Telescope grep" } },
      ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", { desc = "Telescope buffers" } },
      ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", { desc = "Telescope help tags" } },
      ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Telescope current buffer" } },
      ["<leader>fr"] = { "<cmd> Telescope oldfiles <CR>", { desc = "Telescope recent files" } },
      ["<leader>fs"] = { "<cmd> Telescope git_status <CR>", { desc = "Telescope git status" } },
      ["<leader>fc"] = { "<cmd> Telescope git_commits <CR>", { desc = "Telescope git commits" } },
      ["<leader>ma"] = { "<cmd> Telescope marks <CR>", { desc = "Telescope marks" } },
      ["<leader>co"] = {
         "<cmd> Telescope colorscheme enable_preview=true <CR>",
         { desc = "Telescope colorscheme" },
      },
   },
}

M.harpoon = {
   n = {
      ["<leader>jj"] = {
         function()
            require("harpoon.mark").add_file()
         end,
         { desc = "Harpoon add mark" },
      },
      ["<leader>jh"] = {
         function()
            require("harpoon.ui").toggle_quick_menu()
         end,
         { desc = "Harpoon quick menu" },
      },
      ["<leader>jp"] = {
         function()
            require("harpoon.ui").nav_prev()
         end,
         { desc = "Harpoon previous" },
      },
      ["<leader>jn"] = {
         function()
            require("harpoon.ui").nav_next()
         end,
         { desc = "harpoon next" },
      },
      ["<leader>fj"] = { "<cmd> Telescope harpoon marks <CR>", { desc = "Telscope Harpoon marks" } },
   },
}

M.spectre = {
   n = {
      ["<leader>S"] = { "<cmd> lua require('spectre').toggle() <CR>", { desc = "Spectre toggle" } },
      ["<leader>sw"] = {
         "<cmd> lua require('spectre').open_visual({select_word=true}) <CR>",
         { desc = "Spectre search current word" },
      },
      ["<leader>sp"] = {
         "<cmd> lua require('spectre').open_file_search({select_word=true}) <CR>",
         { desc = "Spectre search current file" },
      },
   },
   v = {
      ["<leader>sw"] = {
         "<esc><cmd> lua require('spectre').open_visual() <CR>",
         { desc = "Spectre search current word" },
      },
   },
}

M.todo_comments = {
   n = {
      ["]t"] = {
         function()
            require("todo-comments").jump_next()
         end,
         { desc = "TODO next" },
      },
      -- You can also specify a list of valid jump keywords
      -- ["]t"] = {
      --   function()
      --     require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
      --   end,
      --   { desc = "TODO next" },
      -- },
      ["[t"] = {
         function()
            require("todo-comments").jump_prev()
         end,
         { desc = "TODO previous" },
      },
   },
}

M.carbon_now = {
   v = {
      ["<leader>cn"] = { ":CarbonNow <CR>", { desc = "CarbonNow code selection screenshot" } },
   },
}

M.terminal = {
   n = {
      ["<leader>th"] = { "<cmd> split | terminal <CR>", { desc = "Terminal horizontal" } },
      ["<leader>tv"] = { "<cmd> vsplit | terminal <CR>", { desc = "Terminal vertical" } },
   },
}

M.lazy_git = {
   n = {
      ["<leader>gg"] = { "<cmd> LazyGit <CR>", { desc = "LazyGit" } },
   },
}

------------------------------------------------------------------------------
-- Buffer-local (plugin) key bindings
M.trouble = {
   plugin = true,
   n = {
      ["<leader>xx"] = {
         function()
            require("trouble").toggle()
         end,
         { desc = "Trouble toggle" },
      },
      ["<leader>xw"] = {
         function()
            require("trouble").toggle("workspace_diagnostics")
         end,
         { desc = "Trouble workspace diagnostics" },
      },
      ["<leader>xd"] = {
         function()
            require("trouble").toggle("document_diagnostics")
         end,
         { desc = "Trouble document diagnostics" },
      },
      ["<leader>xq"] = {
         function()
            require("trouble").toggle("quickfix")
         end,
         { desc = "Trouble quickfix" },
      },
      ["<leader>xl"] = {
         function()
            require("trouble").toggle("loclist")
         end,
         { desc = "Trouble loclist" },
      },
      ["<leader>xr"] = {
         function()
            require("trouble").toggle("lsp_references")
         end,
         { desc = "Trouble LSP references" },
      },
   },
}

M.haskell_tools = {
   plugin = true,
   n = {
      -- haskell-language-server relies heavily on codeLenses,
      -- so auto-refresh (see advanced configuration) is enabled by default
      ["<leader>cl"] = { vim.lsp.codelens.run, { desc = "Ht codelens run", noremap = true, silent = true } },

      -- Hoogle search for the type signature of the definition under the cursor
      ["<leader>ts"] = {
         "<cmd> lua require('haskell-tools').hoogle.hoogle_signature() <CR>",
         { desc = "Ht type signature", noremap = true, silent = true },
      },

      -- Hoogle search for the type signature of the definition under the cursor
      ["<leader>ea"] = {
         "<cmd> lua require('haskell-tools').lsp.buf_eval_all() <CR>",
         { desc = "Ht evaluate all code snippets", noremap = true, silent = true },
      },

      -- Toggle a GHCI REPL for the current package
      ["<leader>rr"] = {
         "<cmd> lua require('haskell-tools').repl.toggle() <CR>",
         { desc = "Ht REPL current package" },
      },

      -- Toggle a GHCi REPL for the current buffer
      ["<leader>rf"] = {
         "<cmd> lua require('haskell-tools').repl.toggle(vim.api.nvim_buf_get_name(0)) <CR>",
         { desc = "Ht REPL current buffer" },
      },

      -- Quit GHCi REPL for the current buffer
      ["<leader>rq"] = {
         "<cmd> lua require('haskell-tools').repl.quit() <CR>",
         { desc = "Ht REPL quit" },
      },
   },
}

M.rust = {
   plugin = true,
   n = {
      ["<leader>rcu"] = {
         function()
            require("crates").upgrade_all_crates()
         end,
         { desc = "Update crates" },
      },
   },
}

M.go = {
   plugin = true,
   n = {
      ["<leader>gsj"] = { "<cmd> GoTagAdd json <CR>", { desc = "Add JSON struct tags" } },
      ["<leader>gsy"] = { "<cmd> GoTagAdd yaml <CR>", { desc = "Add YAML struct tags" } },
   },
}

M.nvim_dap = {
   plugin = true,
   n = {
      ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", { desc = "DAP add breakpoint at line" } },
      ["<leader>dr"] = { "<cmd> DapContinue <CR>", { desc = "DAP start or continue the debugger" } },
      ["<leader>dus"] = {
         function()
            local widgets = require("dap.ui.widgets")
            local sidebar = widgets.sidebar(widgets.scopes)
            sidebar.open()
         end,
         { desc = "DAP open debugging sidebar" },
      },
   },
}

M.nvim_dap_python = {
   plugin = true,
   n = {
      ["<leader>dpr"] = {
         function()
            require("dap-python").test_method()
         end,
         { desc = "DAP Python debug unit testing" },
      },
   },
}

M.nvim_dap_go = {
   plugin = true,
   n = {
      ["<leader>dgt"] = {
         function()
            require("dap-go").debug_test()
         end,
         { desc = "Debug Go test" },
      },
      ["<leader>dgl"] = {
         function()
            require("dap-go").debug_last()
         end,
         { desc = "Debug Go last test" },
      },
   },
}

M.nvim_lspconfig = {
   plugin = true,
   n = {
      ["gD"] = { vim.lsp.buf.declaration, { desc = "LSP go to declaration" } },
      ["gd"] = { vim.lsp.buf.definition, { desc = "LSP go to definition" } },
      ["K"] = { vim.lsp.buf.hover, { desc = "LSP hover" } },
      ["gi"] = { vim.lsp.buf.implementation, { desc = "LSP go to implementation" } },
      ["<C-k>"] = { vim.lsp.buf.signature_help, { desc = "LSP signature help" } },
      ["[<leader>wa"] = { vim.lsp.buf.add_workspace_folder, { desc = "LSP add workspace folder" } },
      ["[<leader>wr"] = { vim.lsp.buf.remove_workspace_folder, { desc = "LSP delete workspace folder" } },
      ["<leader>wl"] = {
         function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
         end,
         { desc = "LSP list workspace folders" },
      },
      ["<leader>D"] = { vim.lsp.buf.type_definition, { desc = "LSP type definition" } },
      ["<leader>rn"] = { vim.lsp.buf.rename, { desc = "LSP rename" } },
      ["<leader>ca"] = { vim.lsp.buf.code_action, { desc = "LSP code actions" } },
      ["gr"] = { vim.lsp.buf.references, { desc = "LSP references" } },
      ["<leader>fm"] = {
         function()
            vim.lsp.buf.format({ async = true })
         end,
         { desc = "LSP format" },
      },
   },
   v = {
      ["<leader>ca"] = { vim.lsp.buf.code_action, { desc = "LSP code actions" } },
   },
}

M.compile_and_run_current_cpp = {
   plugin = true,
   n = {
      ["<leader>cx"] = {
         function()
            local current_file = vim.fn.expand("%:p")
            local output_file = current_file:gsub("%..-$", "")
            local terminal_cmd = '!bash -c "make ' .. output_file .. " && " .. output_file .. '"'
            vim.api.nvim_command(terminal_cmd)
         end,
         { desc = "Compile and run current C/C++ buffer" },
      },
   },
}

return M
