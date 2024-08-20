-- Keymaps

local M = {}

------------------------------------------------------------------------------
-- Global keymaps
M.generic = {
   n = {
      ["<leader>|"] = { "<cmd> vsplit <CR>", { desc = "Split vertically [|]" } },
      ["<leader>-"] = { "<cmd> split <CR>", { desc = "Split horizontally [-]" } },
      ["<leader>q"] = {
         function()
            local util = require("core.util")
            util.smart_bd()
         end,
         { desc = "[Q]uit/close current buffer" },
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
      ["<leader>e"] = { "<cmd> Lexplore 20 <CR>", { desc = "N[e]tRw toggle" } },
   },
}

M.neo_tree = {
   n = {
      ["<leader>n"] = { "<cmd> Neotree toggle <CR>", { desc = "[N]eo-tree toggle" } },
   },
}

M.oil = {
   n = {
      ["<leader>."] = { "<cmd> Oil <CR>", { desc = "Oil [.]" } },
   },
}

M.telescope = {
   n = {
      ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", { desc = "Telescope [f]iles" } },
      ["<leader>fa"] = {
         "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
         { desc = "Telescope [a]ll files" },
      },
      ["<leader>fn"] = {
         "<cmd> lua require('telescope.builtin').find_files{cwd=vim.fn.stdpath 'config'} <CR>",
         { desc = "Telescope [n]vim config files" },
      },
      ["<leader>fg"] = { "<cmd> Telescope live_grep <CR>", { desc = "Telescope [g]rep" } },
      ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", { desc = "Telescope [b]uffers" } },
      ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", { desc = "Telescope [h]elp tags" } },
      ["<leader>fz"] = {
         "<cmd> Telescope current_buffer_fuzzy_find <CR>",
         { desc = "Telescope fu[z]zy find current buffer" },
      },
      ["<leader>fe"] = { "<cmd> Telescope oldfiles <CR>", { desc = "Telescope r[e]cent files" } },
      -- Consider using pcall here
      ["<leader>fc"] = { "<cmd> Telescope git_commits <CR>", { desc = "Telescope Git [c]ommits" } },
      ["<leader>ft"] = { "<cmd> Telescope git_files <CR>", { desc = "Telescope Gi[t] files" } },
      ["<leader>fs"] = { "<cmd> Telescope git_status <CR>", { desc = "Telescope Git [s]tatus" } },
      ["<leader>ma"] = { "<cmd> Telescope marks <CR>", { desc = "Telescope [m]arks" } },
      ["<leader>co"] = {
         "<cmd> Telescope colorscheme enable_preview=true <CR>",
         { desc = "Telescope [c][o]lorscheme" },
      },
      ["<leader>fd"] = { "<cmd> Telescope lsp_definitions <CR>", { desc = "Telescope LSP [d]definitions" } },
      ["<leader>fr"] = { "<cmd> Telescope lsp_references <CR>", { desc = "Telescope LSP [r]ferences" } },
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
         { desc = "Harpoon [p]revious" },
      },
      ["<leader>jn"] = {
         function()
            local harpoon = require("harpoon")
            harpoon:list():next()
         end,
         { desc = "Harpoon [n]ext" },
      },
      ["<leader>j1"] = {
         function()
            local harpoon = require("harpoon")
            harpoon:list():select(1)
         end,
         {
            desc = "Harpoon [1]",
         },
      },
      ["<leader>j2"] = {
         function()
            local harpoon = require("harpoon")
            harpoon:list():select(2)
         end,
         {
            desc = "Harpoon [2]",
         },
      },
      ["<leader>j3"] = {
         function()
            local harpoon = require("harpoon")
            harpoon:list():select(3)
         end,
         {
            desc = "Harpoon [3]",
         },
      },
      ["<leader>j4"] = {
         function()
            local harpoon = require("harpoon")
            harpoon:list():select(4)
         end,
         {
            desc = "Harpoon [4]",
         },
      },
      ["<leader>fj"] = { "<cmd> Telescope harpoon marks <CR>", { desc = "Telescope Harpoon marks" } },
   },
}

M.spectre = {
   n = {
      ["<leader>S"] = { "<cmd> lua require('spectre').toggle() <CR>", { desc = "[S]pectre toggle" } },
      ["<leader>sw"] = {
         "<cmd> lua require('spectre').open_visual({select_word=true}) <CR>",
         { desc = "[S]pectre search current [w]ord" },
      },
      ["<leader>sf"] = {
         "<cmd> lua require('spectre').open_file_search({select_word=true}) <CR>",
         { desc = "[S]pectre search current [f]ile" },
      },
   },
   v = {
      ["<leader>sw"] = {
         "<esc><cmd> lua require('spectre').open_visual() <CR>",
         { desc = "[S]pectre search current [w]ord" },
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
      ["<leader>fT"] = {
         function()
            require("todo-comments")
            vim.cmd("TodoTelescope")
         end,
         { desc = "Telescope [T]odo" },
      },
      ["<leader>xT"] = {
         function()
            require("todo-comments")
            vim.cmd("TodoTrouble")
         end,
         { desc = "Trouble [T]odo" },
      },
   },
}

M.carbon_now = {
   [{ "n", "v" }] = {
      ["<leader>cn"] = { ":CarbonNow <CR>", { desc = "[C]arbon[N]ow (visual selection) screenshot" } },
   },
}

M.terminal = {
   n = {
      ["<leader>th"] = { "<cmd> split | terminal <CR>", { desc = "[T]erminal [h]orizontal (terminal)" } },
      ["<leader>tv"] = { "<cmd> vsplit | terminal <CR>", { desc = "[T]erminal [v]ertical (terminal)" } },
   },
}

M.lazy_git = {
   n = {
      ["<leader>lg"] = { "<cmd> LazyGit <CR>", { desc = "[L]azy[G]it (git)" } },
   },
}

M.color_toggle = {
   n = {
      ["<leader>tl"] = {
         function()
            local ui = require("core.ui")
            local state = require("core.state")
            state.color_toggle_current.manual_set = true
            ui.set_light_scheme(state.color_toggle_current["light"])
         end,
         { desc = "[T]heme [l]ight" },
      },
      ["<leader>td"] = {
         function()
            local ui = require("core.ui")
            local state = require("core.state")
            state.color_toggle_current.manual_set = true
            ui.set_dark_scheme(state.color_toggle_current["dark"])
         end,
         { desc = "[T]heme [d]ark" },
      },
      ["<leader>tt"] = {
         function()
            local ui = require("core.ui")
            local state = require("core.state")
            state.color_toggle_current.manual_set = true
            if state.color_toggle_current.light_scheme_set then
               ui.set_dark_scheme(state.color_toggle_current["dark"])
            else
               ui.set_light_scheme(state.color_toggle_current["light"])
            end
         end,
         { desc = "[T]heme [t]oggle, light <-> dark toggle" },
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
         { desc = "D[a]shboard" },
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
         { desc = "[H]ardtime [d]isable" },
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
         { desc = "[H]ardtime [e]nable" },
      },
      ["<leader>hr"] = {
         function()
            require("hardtime")
            vim.cmd("Hardtime report")
         end,
         { desc = "[H]ardtime [r]eport" },
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
         { desc = "[H]ardtime [t]oggle (toggle)" },
      },
   },
}

------------------------------------------------------------------------------
-- Global keymaps for key-triggered lazy-loaded plugins
M.outline = {
   plugin = true,
   keys = {
      { "<leader>so", "<cmd> Outline! <CR>", desc = "Outline [s]ymbols t[o]ggle (toggle)" },
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
         desc = "Trouble [s]ymbols",
      },
      {
         "<leader>cl",
         "<cmd> Trouble lsp toggle focus=false win.position=right <CR>",
         desc = "Trouble [L]SP definitions/references",
      },
      {
         "<leader>xL",
         "<cmd> Trouble loclist toggle <CR>",
         desc = "Trouble [L]ocation list",
      },
      {
         "<leader>xQ",
         "<cmd> Trouble qflist toggle <CR>",
         desc = "Trouble [Q]uickfix list",
      },
   },
}

M.which_key = {
   plugin = true,
   keys = {
      {
         "<leader>?",
         function()
            require("which-key").show({ global = false })
         end,
         desc = "Buffer-local keymaps",
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

M.undotree = {
   plugin = true,
   keys = {
      { "<leader>u", "<cmd> UndotreeToggle <CR>", desc = "[U]ndotree toggle" },
   },
}

------------------------------------------------------------------------------
-- Buffer-local (plugin) keymaps
M.haskell_tools = {
   plugin = true,
   n = {
      -- haskell-language-server relies heavily on codeLenses,
      -- so auto-refresh (see advanced configuration) is enabled by default
      ["<leader>cr"] = { vim.lsp.codelens.run, { desc = "Ht [c]odelens [r]un", noremap = true, silent = true } },

      -- Hoogle search for the type signature of the definition under the cursor
      ["<leader>ts"] = {
         "<cmd> lua require('haskell-tools').hoogle.hoogle_signature() <CR>",
         { desc = "Ht [t]ype [s]ignature", noremap = true, silent = true },
      },

      -- Hoogle search for the type signature of the definition under the cursor
      ["<leader>ea"] = {
         "<cmd> lua require('haskell-tools').lsp.buf_eval_all() <CR>",
         { desc = "Ht [e]valuate [a]ll code snippets", noremap = true, silent = true },
      },

      -- Toggle a GHCI REPL for the current package
      ["<leader>rr"] = {
         "<cmd> lua require('haskell-tools').repl.toggle() <CR>",
         { desc = "Ht [R]EPL cu[r]rent package" },
      },

      -- Toggle a GHCi REPL for the current buffer
      ["<leader>rf"] = {
         "<cmd> lua require('haskell-tools').repl.toggle(vim.api.nvim_buf_get_name(0)) <CR>",
         { desc = "Ht [R]EPL current bu[f]fer" },
      },

      -- Quit GHCi REPL for the current buffer
      ["<leader>rq"] = {
         "<cmd> lua require('haskell-tools').repl.quit() <CR>",
         { desc = "Ht [R]EPL [q]uit" },
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
         { desc = "[R]ust [u]pdate [c]rates" },
      },
   },
}

M.go = {
   plugin = true,
   n = {
      ["<leader>gsj"] = { "<cmd> GoTagAdd json <CR>", { desc = "Add struct ta[g][s] [J]SON" } },
      ["<leader>gsy"] = { "<cmd> GoTagAdd yaml <CR>", { desc = "Add struct ta[g][s] [Y]AML" } },
   },
}

M.nvim_dap = {
   plugin = true,
   n = {
      ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", { desc = "[D]AP add [b]reakpoint at line" } },
      ["<leader>dr"] = { "<cmd> DapContinue <CR>", { desc = "[D]AP sta[r]t or continue the debugger" } },
      ["<leader>dus"] = {
         function()
            local widgets = require("dap.ui.widgets")
            local sidebar = widgets.sidebar(widgets.scopes)
            sidebar.open()
         end,
         { desc = "[D]AP open deb[u]gging [s]idebar" },
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
         { desc = "[D]AP [P]ython [r]un unit testing" },
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
         { desc = "[D]ebug [G]o [t]est" },
      },
      ["<leader>dgl"] = {
         function()
            require("dap-go").debug_last()
         end,
         { desc = "[D]ebug [G]o [l]ast test" },
      },
   },
}

M.nvim_lspconfig = {
   plugin = true,
   n = {
      ["gd"] = { vim.lsp.buf.definition, { desc = "LSP [g]o to [d]efinition" } },
      ["gD"] = { vim.lsp.buf.declaration, { desc = "LSP [g]o to [d]eclaration" } },
      ["K"] = { vim.lsp.buf.hover, { desc = "LSP hover" } },
      ["gi"] = { vim.lsp.buf.implementation, { desc = "LSP [g]o to [i]mplementation" } },
      ["<leader>sh"] = { vim.lsp.buf.signature_help, { desc = "LSP [s]ignature [h]elp" } },
      ["<leader>wa"] = { vim.lsp.buf.add_workspace_folder, { desc = "LSP [w]orkspace [a]dd folder" } },
      ["<leader>wr"] = { vim.lsp.buf.remove_workspace_folder, { desc = "LSP delete [w]orkspace folde[r]" } },
      ["<leader>wl"] = {
         function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
         end,
         { desc = "LSP [w]orkspace [l]ist folders" },
      },
      ["<leader>D"] = { vim.lsp.buf.type_definition, { desc = "LSP type [d]efinition" } },
      ["<leader>rn"] = { vim.lsp.buf.rename, { desc = "LSP [r]e[n]ame" } },
      ["gr"] = { vim.lsp.buf.references, { desc = "LSP [g]o to [r]eferences" } },
      ["<leader>fm"] = {
         function()
            vim.lsp.buf.format({ async = true })
         end,
         { desc = "LSP [f]or[m]at" },
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
         { desc = "LSP [i]nlay [h]ints toggle" },
      },
   },
   [{ "n", "v" }] = {
      ["<leader>ca"] = { vim.lsp.buf.code_action, { desc = "LSP [c]ode [a]ctions" } },
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
         { desc = "[C]ompile and e[x]ecute current C/C++ buffer" },
      },
   },
}

return M
