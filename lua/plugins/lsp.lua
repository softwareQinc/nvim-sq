return {
   -- Manages DAPs, language servers, linters, and formatters
   -- We use mason-lspconfig for language servers, and Mason only for DAPs,
   -- linters and formatters
   {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonUpdate" },
      opts = {
         ui = {
            border = "rounded",
         },
      },
   },
   -- Linters and formatters ONLY. DO NOT add LSP servers or DAPs here.
   -- LSPs are installed later in this file, see mason-lsp-config:setup({...})
   -- DAPs are installed in "dap.lua", see mason-nvim-dap:setup({...})
   {
      "jay-babu/mason-null-ls.nvim",
      dependencies = { "nvimtools/none-ls.nvim", "williamboman/mason.nvim" },
      opts = {
         ensure_installed = {
            -- Formatters
            "black",
            "gofumpt",
            "goimports-reviser",
            "golines",
            "latexindent",
            "prettier",
            "shfmt",
            "stylua",

            -- Linters
            "cmakelang",
            "cmakelint",
            "mypy",
            "shellcheck",
         },
      },
   },
   -- Manages (installs/removes etc.) language servers only
   {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "neovim/nvim-lspconfig" },
      opts = {
         -- LSP servers
         ensure_installed = {
            "bashls",
            "clangd",
            "cmake",
            "gopls",
            "julials",
            "lua_ls",
            "marksman",
            "pyright",
            "ruff",
            "rust_analyzer",
            "texlab",
            "vimls",
            "zls",
            -- "hls", -- not needed, we use haskell-tools.nvim
         },
      },
   },
   -- LSP (Language Server Protocol)
   {
      "neovim/nvim-lspconfig",
      event = "LspAttach",
      config = function()
         local util = require("core.util")
         local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

         local augroup =
            vim.api.nvim_create_augroup("LSP-formatting", { clear = true })
         local lsp_format_on_save = util.format_on_save(augroup)

         -- TODO: Eventually switch to the native nvim 0.11 LSP autocompletion
         lsp_capabilities = vim.tbl_deep_extend(
            "force",
            lsp_capabilities,
            require("cmp_nvim_lsp").default_capabilities()
         )

         -- C++
         vim.lsp.config("clangd", {
            capabilities = lsp_capabilities,
            on_attach = lsp_format_on_save,
            cmd = {
               "clangd",
               "--header-insertion=never",
               "--offset-encoding=utf-16",
            },
         })

         -- Go
         vim.lsp.config("gopls", {
            capabilities = lsp_capabilities,
            on_attach = lsp_format_on_save,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_markers = { "go.work", "go.mod", ".git" },
            settings = {
               gopls = {
                  completeUnimported = true,
                  usePlaceholders = true,
                  analyses = {
                     unusedparams = true,
                  },
                  hints = {
                     assignVariableTypes = true,
                     compositeLiteralFields = true,
                     compositeLiteralTypes = true,
                     constantValues = true,
                     functionTypeParameters = true,
                     parameterNames = true,
                     rangeVariableTypes = true,
                  },
               },
            },
         })

         -- BUG: Julia - new nvim 0.11 config style does not yet work
         -- Client julials quit with exit code 1 and signal 0
         -- vim.lsp.config("julials", {
         --    capabilities = lsp_capabilities,
         --    on_attach = lsp_format_on_save,
         -- })

         -- Julia - nvim 0.10 config style
         require("lspconfig").julials.setup({
            capabilities = lsp_capabilities,
            on_attach = lsp_format_on_save,
         })

         -- Lua
         vim.lsp.config("lua_ls", {
            capabilities = lsp_capabilities,
            on_attach = lsp_format_on_save,
            settings = {
               Lua = {
                  hint = { enable = true },
                  format = {
                     enable = false, -- we use StyLua via none-ls
                  },
               },
            },
         })

         -- Rust
         vim.lsp.config("rust_analyzer", {
            capabilities = lsp_capabilities,
            on_attach = lsp_format_on_save,
            filetypes = { "rust" },
            root_markers = { "Cargo.toml" },
            settings = {
               ["rust-analyzer"] = {
                  cargo = {
                     allFeatures = true,
                  },
               },
            },
         })

         -- LaTeX
         vim.lsp.config("texlab", {
            capabilities = lsp_capabilities,
            on_attach = lsp_format_on_save,
            settings = {
               texlab = {
                  latexindent = {
                     modifyLineBreaks = true,
                  },
               },
            },
         })

         -- Zig
         vim.lsp.config("zls", {
            capabilities = lsp_capabilities,
            on_attach = lsp_format_on_save,
         })

         vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup(
               "Nvim-lspconfig",
               { clear = true }
            ),
            callback = function(ev)
               -- Disable semantic token highlighting for lua_ls
               local client = vim.lsp.get_client_by_id(ev.data.client_id)
               if client and client.name and client.name == "lua_ls" then
                  client.server_capabilities.semanticTokensProvider = nil
               end
               -- Enable completion triggered by <c-x><c-o>
               vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
               -- Buffer-local keymaps
               local keymaps = require("core.keymaps")
               util.map_keys(keymaps.nvim_lspconfig, { buffer = ev.buf })
               -- Diagnostics
               local diagnostic_signs = {
                  [vim.diagnostic.severity.ERROR] = "",
                  [vim.diagnostic.severity.WARN] = "",
                  [vim.diagnostic.severity.INFO] = "",
                  [vim.diagnostic.severity.HINT] = "󰌵",
               }
               local shorter_source_names = {
                  ["Lua Diagnostics."] = "Lua",
                  ["Lua Syntax Check."] = "Lua",
               }
               local function diagnostic_format(diagnostic)
                  return string.format(
                     "%s %s (%s): %s",
                     diagnostic_signs[diagnostic.severity],
                     shorter_source_names[diagnostic.source]
                        or diagnostic.source,
                     diagnostic.code,
                     diagnostic.message
                  )
               end

               vim.diagnostic.config({
                  virtual_text = {
                     current_line = true,
                     spacing = 4,
                     prefix = "",
                     format = diagnostic_format,
                  },
                  -- signs = {
                  --    text = diagnostic_signs,
                  -- },
                  -- virtual_lines = {
                  --    current_line = true,
                  --    format = diagnostic_format,
                  -- },
                  underline = true,
                  -- update_in_insert = true,
                  severity_sort = true,
               })
            end,
            desc = "Keymaps nvim-lspconfig (buffer-local)",
         })
      end,
   },
}
