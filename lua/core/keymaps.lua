-- Keymaps

local M = {}

------------------------------------------------------------------------------
-- Global keymaps
M.generic = {
   n = {
      ["<leader>|"] = {
         "<cmd> vsplit <CR>",
         { desc = "Split vertically [|]" },
      },
      ["<leader>-"] = {
         "<cmd> split <CR>",
         { desc = "Split horizontally [-]" },
      },
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

      ["<leader>bl"] = {
         function()
            vim.opt.background = "light"
         end,
         { desc = "[B]ackground [l]ight" },
      },
      ["<leader>bd"] = {
         function()
            vim.opt.background = "dark"
         end,
         { desc = "[B]ackground [d]ark" },
      },
      ["<leader>bt"] = {
         function()
            ---@diagnostic disable-next-line: undefined-field
            if vim.opt.background:get() == "light" then
               vim.opt.background = "dark"
            else
               vim.opt.background = "light"
            end
         end,
         { desc = "[B]ackground [t]oggle, light <-> dark toggle" },
      },

      ["<M-h>"] = { "<C-w>5<", { desc = "Resize split right" } },
      ["<M-l>"] = { "<C-w>5>", { desc = "Resize split left" } },
      ["<M-k>"] = { "<C-w>5-", { desc = "Resize split up" } },
      ["<M-j>"] = { "<C-w>5+", { desc = "Resize split down" } },
   },
   -- [{ "n", "i", "v", "x" }] = {
   --    ["<Up>"] = { "<Nop>" },
   --    ["<Down>"] = { "<Nop>" },
   --    ["<Left>"] = { "<Nop>" },
   --    ["<Right>"] = { "<Nop>" },
   -- },
}

M.carbon_now = {
   n = {
      ["<leader>cn"] = {
         ":CarbonNow <CR>",
         { desc = "[C]arbon[N]ow screenshot" },
      },
   },
   x = {
      ["<leader>cn"] = {
         ":CarbonNow <CR>",
         { desc = "[C]arbon[N]ow (visual selection) screenshot" },
      },
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
            vim.cmd("Hardtime disable")
            local state = require("core.state")
            state.hardtime_enabled_at_startup = false
            print("Hardtime: false")
         end,
         { desc = "[H]ardtime [d]isable" },
      },
      ["<leader>he"] = {
         function()
            vim.cmd("Hardtime enable")
            local state = require("core.state")
            state.hardtime_enabled_at_startup = true
            print("Hardtime: true")
         end,
         { desc = "[H]ardtime [e]nable" },
      },
      ["<leader>hr"] = {
         function()
            vim.cmd("Hardtime report")
         end,
         { desc = "[H]ardtime [r]eport" },
      },
      ["<leader>ht"] = {
         function()
            vim.cmd("Hardtime toggle")
            local state = require("core.state")
            state.hardtime_enabled_at_startup =
               not state.hardtime_enabled_at_startup
            print("Hardtime:", state.hardtime_enabled_at_startup)
         end,
         { desc = "[H]ardtime [t]oggle (toggle)" },
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
      ["<leader>fj"] = {
         "<cmd> Telescope harpoon marks <CR>",
         { desc = "Telescope Harpoon marks" },
      },
   },
}

M.lazy_git = {
   n = {
      ["<leader>lg"] = { "<cmd> LazyGit <CR>", { desc = "[L]azy[G]it (git)" } },
   },
}

M.neo_tree = {
   n = {
      ["<leader>n"] = {
         "<cmd> Neotree toggle <CR>",
         { desc = "[N]eo-tree toggle" },
      },
   },
}

M.netrw = {
   n = {
      ["<leader>e"] = { "<cmd> Lexplore 20 <CR>", { desc = "N[e]tRw toggle" } },
   },
}

M.nvim_treesitter_context = {
   n = {
      ["<leader>tc"] = {
         function()
            local tsc = require("treesitter-context")
            tsc.toggle()
            print("Tree-sitter context:", tsc.enabled())
         end,
         { desc = "[T]ree-sitter [c]ontext toggle" },
      },
      ["[^"] = {
         function()
            local tsc = require("treesitter-context")
            tsc.go_to_context(vim.v.count1)
         end,
         {
            desc = "Tree-sitter jump to parent context (repeatable with count)",
         },
      },
   },
}

M.oil = {
   n = {
      ["<leader>."] = { "<cmd> Oil <CR>", { desc = "Oil [.]" } },
   },
}

M.spectre = {
   n = {
      ["<leader>S"] = {
         "<cmd> lua require('spectre').toggle() <CR>",
         { desc = "[S]pectre toggle" },
      },
      ["<leader>sw"] = {
         "<cmd> lua require('spectre').open_visual({select_word=true}) <CR>",
         { desc = "[S]pectre search current [w]ord" },
      },
      ["<leader>sf"] = {
         "<cmd> lua require('spectre').open_file_search({select_word=true}) <CR>",
         { desc = "[S]pectre search current [f]ile" },
      },
      ["<leader>sq"] = {
         "<cmd> lua require('spectre.actions').send_to_qf() <CR>",
         { desc = "[S]pectre send all items to [q]uickfix list" },
      },
   },
   x = {
      ["<leader>sw"] = {
         "<esc><cmd> lua require('spectre').open_visual() <CR>",
         { desc = "[S]pectre search current [w]ord" },
      },
   },
}

M.telescope = {
   n = {
      ["<leader>ff"] = {
         "<cmd> Telescope find_files <CR>",
         { desc = "Telescope [f]iles" },
      },
      ["<leader>fa"] = {
         "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
         { desc = "Telescope [a]ll files" },
      },
      ["<leader>fn"] = {
         "<cmd> lua require('telescope.builtin').find_files{cwd=vim.fn.stdpath 'config'} <CR>",
         { desc = "Telescope [n]vim config files" },
      },
      ["<leader>fg"] = {
         "<cmd> Telescope live_grep <CR>",
         { desc = "Telescope [g]rep" },
      },
      ["<leader>fG"] = {
         function()
            require("telescope.builtin").live_grep({ grep_open_files = true })
         end,
         { desc = "Telescope [G]rep local buffers" },
      },
      ["<leader>fS"] = {
         "<cmd> Telescope grep_string <CR>",
         { desc = "Telescope grep [S]tring" },
      },
      ["<leader>fT"] = {
         function()
            require("telescope.builtin").grep_string({ grep_open_files = true })
         end,
         { desc = "Telescope grep s[T]ring local buffers" },
      },
      ["<leader>fb"] = {
         "<cmd> Telescope buffers <CR>",
         { desc = "Telescope [b]uffers" },
      },
      ["<leader>fh"] = {
         "<cmd> Telescope help_tags <CR>",
         { desc = "Telescope [h]elp tags" },
      },
      ["<leader>fz"] = {
         "<cmd> Telescope current_buffer_fuzzy_find <CR>",
         { desc = "Telescope fu[z]zy find current buffer" },
      },
      ["<leader>fe"] = {
         "<cmd> Telescope oldfiles <CR>",
         { desc = "Telescope r[e]cent files" },
      },
      -- Consider using pcall here
      ["<leader>fc"] = {
         "<cmd> Telescope git_commits <CR>",
         { desc = "Telescope Git [c]ommits" },
      },
      ["<leader>fC"] = {
         "<cmd> Telescope git_bcommits <CR>",
         { desc = "Telescope Git buffer [C]ommits" },
      },
      ["<leader>fi"] = {
         "<cmd> Telescope git_files <CR>",
         { desc = "Telescope G[i]t files" },
      },
      ["<leader>fs"] = {
         "<cmd> Telescope git_status <CR>",
         { desc = "Telescope Git [s]tatus" },
      },
      ["<leader>f'"] = {
         "<cmd> Telescope marks <CR>",
         { desc = "Telescope marks" },
      },
      ["<leader>co"] = {
         "<cmd> Telescope colorscheme enable_preview=true <CR>",
         { desc = "Telescope [co]lorscheme" },
      },
   },
}

M.terminal = {
   n = {
      ["<leader>th"] = {
         "<cmd> split | terminal <CR>",
         { desc = "[T]erminal [h]orizontal (terminal)" },
      },
      ["<leader>tv"] = {
         "<cmd> vsplit | terminal <CR>",
         { desc = "[T]erminal [v]ertical (terminal)" },
      },
      ["<leader>tf"] = {
         "<cmd> FloatermNew <CR>",
         { desc = "[T]erminal [f]float (terminal)" },
      },
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
      -- function()
      --    require("todo-comments").jump_next({
      --       keywords = { "ERROR", "WARNING" },
      --    })
      -- end,
      --   { desc = "TODO next" },
      -- },
      ["[t"] = {
         function()
            require("todo-comments").jump_prev()
         end,
         { desc = "TODO previous" },
      },
      ["<leader>ft"] = {
         function()
            require("todo-comments")
            vim.cmd("TodoTelescope")
         end,
         { desc = "Telescope [t]odo" },
      },
      ["<leader>xt"] = {
         function()
            require("todo-comments")
            vim.cmd("TodoTrouble")
         end,
         { desc = "Trouble [t]odo" },
      },
   },
}

------------------------------------------------------------------------------
-- Global keymaps for key-triggered (lazy-loaded) plugins
M.background_transparency = {
   plugin = true,
   n = {
      ["<leader>br"] = {
         function()
            local state = require("core.state")
            local ui = require("core.ui")
            state.background_transparency_enabled_at_startup =
               not state.background_transparency_enabled_at_startup
            ui.toggle_background_transparency()
            -- Hack to delay message slightly so it prints
            -- **after** color-related  updates
            vim.defer_fn(function()
               print(
                  "Background transparency:",
                  state.background_transparency_enabled_at_startup
               )
            end, 1)
         end,
         {
            desc = "[B]ackground t[r]ansparency toggle",
         },
      },
   },
}

M.nvim_treesitter = {
   plugin = true,
   keymaps = {
      init_selection = "<leader>ss",
      -- The keymaps below become active only after init_selection is triggered
      node_incremental = "<leader>si",
      scope_incremental = "<leader>sc",
      node_decremental = "<leader>sd",
   },
}

M.outline = {
   plugin = true,
   keys = {
      {
         "<leader>so",
         "<cmd> Outline! <CR>",
         desc = "Outline [s]ymbols t[o]ggle (toggle)",
      },
   },
}

M.trouble = {
   plugin = true,
   keys = {
      {
         "<leader>xd",
         "<cmd> Trouble lsp toggle focus=false win.position=right <CR>",
         desc = "Trouble LSP [d]efinitions/references",
      },
      {
         "<leader>xl",
         "<cmd> Trouble loclist toggle <CR>",
         desc = "Trouble [l]ocation list",
      },
      {
         "<leader>xq",
         "<cmd> Trouble qflist toggle <CR>",
         desc = "Trouble [q]uickfix list",
      },
      {
         "<leader>xs",
         "<cmd> Trouble symbols toggle focus=false <CR>",
         desc = "Trouble [s]ymbols",
      },
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
   },
}

M.undotree = {
   plugin = true,
   keys = {
      { "<leader>u", "<cmd> UndotreeToggle <CR>", desc = "[U]ndotree toggle" },
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
         desc = "Buffer-local keymaps (which-key)",
      },
   },
}

------------------------------------------------------------------------------
-- Buffer-local (plugin) keymaps
M.compile_and_run_current_cpp = {
   plugin = true,
   n = {
      ["<leader>cx"] = {
         function()
            local current_file = vim.fn.expand("%:p")
            local output_file = vim.fn.fnamemodify(current_file, ":r")
            local terminal_cmd = "split | term " .. vim.o.shell .. ' -c "make '
            if vim.v.count > 0 then
               local flag = (vim.bo.filetype == "c") and "CFLAGS=-std=c"
                  or "CXXFLAGS=-std=c++"
               terminal_cmd = terminal_cmd .. flag .. vim.v.count .. " "
            end
            terminal_cmd = terminal_cmd
               .. output_file
               .. " && "
               .. output_file
               .. '"'
            vim.api.nvim_command(terminal_cmd)
         end,
         { desc = "[C]ompile and e[x]ecute current C/C++ buffer" },
      },
   },
}

M.go = {
   plugin = true,
   n = {
      ["<leader>gsj"] = {
         "<cmd> GoTagAdd json <CR>",
         { desc = "Add struct ta[gs] [j]SON" },
      },
      ["<leader>gsy"] = {
         "<cmd> GoTagAdd yaml <CR>",
         { desc = "Add struct ta[gs] [y]AML" },
      },
   },
}

M.haskell_tools = {
   plugin = true,
   n = {
      -- haskell-language-server relies heavily on codeLenses,
      -- so auto-refresh (see advanced configuration) is enabled by default
      ["<leader>cr"] = {
         vim.lsp.codelens.run,
         { desc = "Ht [c]odelens [r]un", noremap = true, silent = true },
      },

      -- Hoogle search for the type signature of the definition under the cursor
      ["<leader>ts"] = {
         "<cmd> lua require('haskell-tools').hoogle.hoogle_signature() <CR>",
         { desc = "Ht [t]ype [s]ignature", noremap = true, silent = true },
      },

      -- Hoogle search for the type signature of the definition under the cursor
      ["<leader>ea"] = {
         "<cmd> lua require('haskell-tools').lsp.buf_eval_all() <CR>",
         {
            desc = "Ht [e]valuate [a]ll code snippets",
            noremap = true,
            silent = true,
         },
      },

      -- Toggle a GHCI REPL for the current package
      ["<leader>rr"] = {
         "<cmd> lua require('haskell-tools').repl.toggle() <CR>",
         { desc = "Ht [r]EPL cu[r]rent package" },
      },

      -- Toggle a GHCi REPL for the current buffer
      ["<leader>rf"] = {
         "<cmd> lua require('haskell-tools').repl.toggle(vim.api.nvim_buf_get_name(0)) <CR>",
         { desc = "Ht [r]EPL current bu[f]fer" },
      },

      -- Quit GHCi REPL for the current buffer
      ["<leader>rq"] = {
         "<cmd> lua require('haskell-tools').repl.quit() <CR>",
         { desc = "Ht [r]EPL [q]uit" },
      },
   },
}

M.nvim_dap = {
   plugin = true,
   n = {
      ["<leader>db"] = {
         "<cmd> DapToggleBreakpoint <CR>",
         { desc = "[D]AP add [b]reakpoint at line" },
      },
      ["<leader>dr"] = {
         "<cmd> DapContinue <CR>",
         { desc = "[D]AP sta[r]t or continue the debugger" },
      },
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

M.nvim_dap_go = {
   plugin = true,
   n = {
      ["<leader>dgt"] = {
         function()
            require("dap-go").debug_test()
         end,
         { desc = "[D]ebug [g]o [t]est" },
      },
      ["<leader>dgl"] = {
         function()
            require("dap-go").debug_last()
         end,
         { desc = "[D]ebug [g]o [l]ast test" },
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
         { desc = "[D]AP [p]ython [r]un unit testing" },
      },
   },
}

M.nvim_lspconfig = {
   plugin = true,
   n = {
      ["gd"] = {
         vim.lsp.buf.definition,
         { desc = "LSP [g]o to [d]efinition" },
      },
      ["gD"] = {
         vim.lsp.buf.declaration,
         { desc = "LSP [g]o to [D]eclaration" },
      },
      ["K"] = {
         function()
            vim.lsp.buf.hover()
         end,
         { desc = "LSP hover" },
      },
      -- NOTE: Implemented by default in nvim 0.11 as `gri`
      ["gi"] = {
         vim.lsp.buf.implementation,
         { desc = "LSP [g]o to [i]mplementation" },
      },
      ["<leader>sh"] = {
         function()
            vim.lsp.buf.signature_help()
         end,
         { desc = "LSP [s]ignature [h]elp" },
      },
      ["<leader>wa"] = {
         vim.lsp.buf.add_workspace_folder,
         { desc = "LSP [w]orkspace [a]dd folder" },
      },
      ["<leader>wr"] = {
         vim.lsp.buf.remove_workspace_folder,
         { desc = "LSP delete [w]orkspace folde[r]" },
      },
      ["<leader>wl"] = {
         function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
         end,
         { desc = "LSP [w]orkspace [l]ist folders" },
      },
      ["<leader>D"] = {
         vim.lsp.buf.type_definition,
         { desc = "LSP type [D]efinition" },
      },
      -- NOTE: Implemented by default in nvim 0.11 as `grn`
      ["<leader>rn"] = { vim.lsp.buf.rename, { desc = "LSP [r]e[n]ame" } },
      -- NOTE: Implemented by default in nvim 0.11 as `grr`
      ["gs"] = {
         vim.lsp.buf.references,
         { desc = "LSP [g]o to reference[s]" },
      },
      ["<leader>fos"] = {
         function()
            local state = require("core.state")
            state.lsp_format_on_save_enabled_at_startup =
               not state.lsp_format_on_save_enabled_at_startup
            print(
               "LSP format on save:",
               state.lsp_format_on_save_enabled_at_startup
            )
         end,
         { desc = "LSP [fo]rmat on [s]ave toggle" },
      },
      ["<leader>foS"] = {
         function()
            local state = require("core.state")
            if vim.b.lsp_format_on_save_current_buffer == nil then
               vim.b.lsp_format_on_save_current_buffer =
                  state.lsp_format_on_save_enabled_at_startup
            end
            vim.b.lsp_format_on_save_current_buffer =
               not vim.b.lsp_format_on_save_current_buffer
            print(
               "LSP format on save (current buffer):",
               vim.b.lsp_format_on_save_current_buffer
            )
         end,
         { desc = "LSP [fo]rmat on [S]ave current buffer toggle" },
      },
      ["<leader>fd"] = {
         "<cmd> Telescope lsp_definitions <CR>",
         { desc = "Telescope LSP [d]efinitions" },
      },
      ["<leader>fr"] = {
         "<cmd> Telescope lsp_references <CR>",
         { desc = "Telescope LSP [r]eferences" },
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
      -- LSP diagnostics via virtual lines/text
      ["<leader>dl0"] = {
         function()
            local util = require("core.util")
            util.lsp_diagnostics_level_0()
         end,
         { desc = "LSP [d]iagnostics [l]evel 0 (no diagnostics)" },
      },
      ["<leader>dl1"] = {
         function()
            local util = require("core.util")
            util.lsp_diagnostics_level_1()
         end,
         { desc = "LSP [d]iagnostics [l]evel 1" },
      },
      ["<leader>dl2"] = {
         function()
            local util = require("core.util")
            util.lsp_diagnostics_level_2()
         end,
         { desc = "LSP [d]iagnostics [l]evel 2" },
      },
      ["<leader>dl3"] = {
         function()
            local util = require("core.util")
            util.lsp_diagnostics_level_3()
         end,
         { desc = "LSP [d]iagnostics [l]evel 3" },
      },
      ["<leader>dl4"] = {
         function()
            local util = require("core.util")
            util.lsp_diagnostics_level_4()
         end,
         { desc = "LSP [d]iagnostics [l]evel 4" },
      },
      ["<leader>dlt"] = {
         function()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
         end,
         { desc = "LSP [d]iagnostics current [l]evel [t]oggle" },
      },
   },
   [{ "n", "x" }] = {
      -- NOTE: Implemented by default in nvim 0.11 as `gra`
      ["<leader>ca"] = {
         vim.lsp.buf.code_action,
         { desc = "LSP [c]ode [a]ctions" },
      },
      ["<leader>fm"] = {
         function()
            vim.lsp.buf.format({ async = true })
         end,
         { desc = "LSP [f]or[m]at" },
      },
   },
}

M.run_current_python = {
   plugin = true,
   n = {
      ["<leader>cx"] = {
         function()
            local current_file = vim.fn.expand("%:p")
            local terminal_cmd = "split | term "
               .. vim.o.shell
               .. ' -c  "python3 '
               .. current_file
               .. '"'
            vim.api.nvim_command(terminal_cmd)
         end,
         { desc = "E[x]ecute current Python buffer" },
      },
   },
}

M.run_current_qasm = {
   plugin = true,
   n = {
      ["<leader>cx"] = {
         ":<C-u>lua vim.cmd('!qpp_qasm <% ' .. vim.v.count1) <CR>",
         { desc = "E[x]ecute with qpp_qasm" },
      },
      ["<leader>cf"] = {
         ":<C-u>lua vim.cmd('!qpp_qasm <% ' .. vim.v.count1 .. ' psi') <CR>",
         { desc = "Execute with qpp_qasm, display the [f]inal state" },
      },
   },
}

M.run_current_zig = {
   plugin = true,
   n = {
      ["<leader>cx"] = {
         function()
            local current_file = vim.fn.expand("%:p")
            local terminal_cmd = "split | term "
               .. vim.o.shell
               .. ' -c "zig run '
               .. current_file
               .. '"'
            vim.api.nvim_command(terminal_cmd)
         end,
         { desc = "E[x]ecute current Zig buffer" },
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
         { desc = "[R]ust [c]rates [u]pdate" },
      },
   },
}

return M
