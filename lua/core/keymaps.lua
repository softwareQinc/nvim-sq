-- Keymaps

local M = {}

------------------------------------------------------------------------------
-- Global keymaps
M.generic = {
   n = {
      ["<leader>|"] = { "<cmd> vsplit <CR>", { desc = "Split vertically" } },
      ["<leader>-"] = { "<cmd> split <CR>", { desc = "Split horizontally" } },
      ["<leader>q"] = {
         function()
            local util = require("core.util")
            util.smart_bd()
         end,
         { desc = "Close current buffer" },
      },
      -- https://vi.stackexchange.com/a/3877
      ["<leader>o"] = { 'o<ESC>0"_D', { desc = "Insert new line below" } },
      ["<leader>O"] = { 'O<ESC>0"_D', { desc = "Insert new line above" } },

      ["<ESC>"] = { "<cmd> nohlsearch <CR>" },

      ["[b"] = { "<cmd> bprevious <CR>", { desc = "Buffer previous" } },
      ["]b"] = { "<cmd> bnext <CR>", { desc = "Buffer next" } },
      ["[B"] = { "<cmd> bfirst <CR>", { desc = "Buffer first" } },
      ["]B"] = { "<cmd> blast <CR>", { desc = "Buffer last" } },

      ["<M-h>"] = { "<C-w>5<", { desc = "Resize split right" } },
      ["<M-l>"] = { "<C-w>5>", { desc = "Resize split left" } },
      ["<M-k>"] = { "<C-w>5-", { desc = "Resize split up" } },
      ["<M-j>"] = { "<C-w>5+", { desc = "Resize split down" } },
   },
   -- [{ "n", "i", "v" }] = {
   --    ["<Up>"] = { "<Nop>" },
   --    ["<Down>"] = { "<Nop>" },
   --    ["<Left>"] = { "<Nop>" },
   --    ["<Right>"] = { "<Nop>" },
   -- },
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
      ["<leader>e"] = { "<cmd> Lexplore 20 <CR>", { desc = "NetRw toggle" } },
   },
}

M.neo_tree = {
   n = {
      ["<leader>n"] = { "<cmd> Neotree toggle <CR>", { desc = "Neo-tree toggle" } },
   },
}

M.oil = {
   n = {
      ["<leader>."] = { "<cmd> Oil <CR>", { desc = "Oil" } },
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
      -- Consider using pcall here
      ["<leader>fc"] = { "<cmd> Telescope git_commits <CR>", { desc = "Telescope Git commits" } },
      ["<leader>ft"] = { "<cmd> Telescope git_files <CR>", { desc = "Telescope Git files" } },
      ["<leader>fs"] = { "<cmd> Telescope git_status <CR>", { desc = "Telescope Git status" } },
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
            local harpoon = require("harpoon")
            harpoon:list():add()
         end,
         { desc = "Harpoon add mark" },
      },
      ["<leader>jh"] = {
         function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
         end,
         { desc = "Harpoon quick menu" },
      },
      ["<leader>jp"] = {
         function()
            local harpoon = require("harpoon")
            harpoon:list():prev()
         end,
         { desc = "Harpoon previous" },
      },
      ["<leader>jn"] = {
         function()
            local harpoon = require("harpoon")
            harpoon:list():next()
         end,
         { desc = "Harpoon next" },
      },
      ["<leader>j1"] = {
         function()
            local harpoon = require("harpoon")
            harpoon:list():select(1)
         end,
         {
            desc = "Harpoon 1",
         },
      },
      ["<leader>j2"] = {
         function()
            local harpoon = require("harpoon")
            harpoon:list():select(2)
         end,
         {
            desc = "Harpoon 2",
         },
      },
      ["<leader>j3"] = {
         function()
            local harpoon = require("harpoon")
            harpoon:list():select(3)
         end,
         {
            desc = "Harpoon 3",
         },
      },
      ["<leader>j4"] = {
         function()
            local harpoon = require("harpoon")
            harpoon:list():select(4)
         end,
         {
            desc = "Harpoon 4",
         },
      },
      ["<leader>fj"] = { "<cmd> Telescope harpoon marks <CR>", { desc = "Telescope Harpoon marks" } },
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
   [{ "n", "v" }] = {
      ["<leader>cn"] = { ":CarbonNow <CR>", { desc = "CarbonNow (visual selection) screenshot" } },
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
      ["<leader>lg"] = { "<cmd> LazyGit <CR>", { desc = "LazyGit" } },
   },
}

M.color_toggle = {
   n = {
      ["<leader>tl"] = {
         function()
            local ui = require("core.ui")
            ui.set_light_scheme(ui.color_toggle_current["light"])
         end,
         { desc = "Theme light" },
      },
      ["<leader>td"] = {
         function()
            local ui = require("core.ui")
            ui.set_dark_scheme(ui.color_toggle_current["dark"])
         end,
         { desc = "Theme dark" },
      },
      ["<leader>tt"] = {
         function()
            local ui = require("core.ui")
            if ui.color_toggle_current.is_light_scheme then
               ui.set_dark_scheme(ui.color_toggle_current["dark"])
            else
               ui.set_light_scheme(ui.color_toggle_current["light"])
            end
         end,
         { desc = "Theme toggle light <-> dark" },
      },
   },
}

M.dashboard = {
   n = {
      ["<leader>a"] = {
         function()
            require("dashboard")
            vim.cmd("Dashboard")
         end,
         { desc = "Dashboard" },
      },
   },
}

M.hardtime = {
   n = {
      ["<leader>hd"] = {
         function()
            require("hardtime")
            local state = require("core.state")
            vim.cmd("Hardtime disable")
            state.hardtime_enabled = false
            -- Restore showmode
            if state.initial_showmode then
               vim.o.showmode = state.initial_showmode
            end
            print("Hardtime: false")
         end,
         { desc = "Hardtime disable" },
      },
      ["<leader>he"] = {
         function()
            require("hardtime")
            local state = require("core.state")
            vim.cmd("Hardtime enable")
            state.hardtime_enabled = true
            vim.o.showmode = false
            print("Hardtime: true")
         end,
         { desc = "Hardtime enable" },
      },
      ["<leader>hr"] = {
         function()
            require("hardtime")
            vim.cmd("Hardtime report")
         end,
         { desc = "Hardtime report" },
      },
      ["<leader>ht"] = {
         function()
            require("hardtime")
            local state = require("core.state")
            vim.cmd("Hardtime toggle")
            state.hardtime_enabled = not state.hardtime_enabled
            if state.hardtime_enabled then
               vim.o.showmode = false
            else
               -- Restore showmode
               if state.initial_showmode then
                  vim.o.showmode = state.initial_showmode
               end
            end
            print("Hardtime:", state.hardtime_enabled)
         end,
         { desc = "Hardtime toggle" },
      },
   },
}

------------------------------------------------------------------------------
-- Global keymaps for key-triggered lazy-loaded plugins
M.outline = {
   plugin = true,
   keys = {
      { "<leader>so", "<cmd> Outline <CR>", desc = "Outline toggle" },
   },
}

M.trouble = {
   plugin = true,
   keys = {
      {
         "<leader>xx",
         "<cmd> Trouble diagnostics toggle <CR>",
         desc = "Trouble diagnostics",
      },
      {
         "<leader>xX",
         "<cmd> Trouble diagnostics toggle filter.buf=0 <CR>",
         desc = "Trouble buffer diagnostics",
      },
      {
         "<leader>cs",
         "<cmd> Trouble symbols toggle focus=false <CR>",
         desc = "Trouble symbols",
      },
      {
         "<leader>cl",
         "<cmd> Trouble lsp toggle focus=false win.position=right <CR>",
         desc = "Trouble LSP definitions/references/...",
      },
      {
         "<leader>xL",
         "<cmd> Trouble loclist toggle <CR>",
         desc = "Trouble Location list",
      },
      {
         "<leader>xQ",
         "<cmd> Trouble qflist toggle <CR>",
         desc = "Trouble Quickfix list",
      },
   },
}

M.nvim_treesitter = {
   plugin = true,
   keymaps = {
      init_selection = "<leader>ss",
      node_incremental = "<leader>si",
      scope_incremental = "<leader>sc",
      node_decremental = "<leader>sd",
   },
}

------------------------------------------------------------------------------
-- Buffer-local (plugin) keymaps
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
      ["gd"] = { vim.lsp.buf.definition, { desc = "LSP go to definition" } },
      ["gD"] = { vim.lsp.buf.declaration, { desc = "LSP go to declaration" } },
      ["K"] = { vim.lsp.buf.hover, { desc = "LSP hover" } },
      ["gi"] = { vim.lsp.buf.implementation, { desc = "LSP go to implementation" } },
      ["<leader>sh"] = { vim.lsp.buf.signature_help, { desc = "LSP signature help" } },
      ["<leader>wa"] = { vim.lsp.buf.add_workspace_folder, { desc = "LSP add workspace folder" } },
      ["<leader>wr"] = { vim.lsp.buf.remove_workspace_folder, { desc = "LSP delete workspace folder" } },
      ["<leader>wl"] = {
         function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
         end,
         { desc = "LSP list workspace folders" },
      },
      ["<leader>D"] = { vim.lsp.buf.type_definition, { desc = "LSP type definition" } },
      ["<leader>rn"] = { vim.lsp.buf.rename, { desc = "LSP rename" } },
      ["gr"] = { vim.lsp.buf.references, { desc = "LSP references" } },
      ["<leader>fm"] = {
         function()
            vim.lsp.buf.format({ async = true })
         end,
         { desc = "LSP format" },
      },
      ["<leader>ih"] = {
         -- LSP inlay hints, requires Neovim 0.10 or later
         function()
            local lsp_inlay_hint = vim.lsp["inlay_hint"]
            if lsp_inlay_hint then
               vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
               print("LSP inlay hints:", vim.lsp.inlay_hint.is_enabled({}))
            else
               print("LSP inlay hints not supported!")
            end
         end,
         { desc = "LSP inlay hints toggle" },
      },
   },
   [{ "n", "v" }] = {
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
            -- local terminal_cmd = '!bash -c "make ' .. output_file .. " && " .. output_file .. '"'
            local terminal_cmd = 'split | term bash -c "make ' .. output_file .. " && " .. output_file .. '"'
            vim.api.nvim_command(terminal_cmd)
         end,
         { desc = "Compile and run current C/C++ buffer" },
      },
   },
}

return M
