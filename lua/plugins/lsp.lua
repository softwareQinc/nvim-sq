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
            "black", -- Python
            "gofumpt", -- Go
            "goimports-reviser", -- Go
            "golines", -- Go
            "latexindent", -- Latex
            "prettier", -- Multiple languages
            "shfmt", -- Bash/sh
            "stylua", -- Lua

            -- Linters
            "cmakelang", -- CMake
            "cmakelint", -- CMake
            "mypy", -- Python
            "shellcheck", -- Bash/sh
         },
      },
   },

   -- Manages (installs/removes etc.) language servers only
   {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "neovim/nvim-lspconfig" },
      opts = {
         -- LSPs that are installed by default
         ensure_installed = {
            "basedpyright", -- Python
            "bashls", -- Bash/sh
            "clangd", -- C, C++
            "cmake", -- C, C++ build system
            "gopls", -- Go
            "hls", -- Haskell
            -- Do not install julials via Mason
            -- https://discourse.julialang.org/t/neovim-languageserver-jl-crashing-again/130273
            -- "julials",
            "lua_ls", -- Lua
            "marksman", -- Markdown
            "tombi", -- TOML
            "ruff", -- Rust
            "rust_analyzer", -- Rust
            "texlab", -- LaTeX
            "vimls", -- Vim
            "yamlls", -- YAML
            "zls", -- Zig
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

         local servers = {
            -- C, C++
            clangd = {
               cmd = {
                  "clangd",
                  "--header-insertion=never",
                  "--offset-encoding=utf-16",
               },
            },

            -- Go
            gopls = {
               cmd = { "gopls" },
               filetypes = { "go", "gomod", "gowork", "gotmpl" },
               root_markers = { "go.work", "go.mod", ".git" },
               settings = {
                  gopls = {
                     completeUnimported = true,
                     usePlaceholders = true,
                     analyses = { unusedparams = true },
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
            },

            -- Julia
            julials = {
               cmd = {
                  "julia",
                  "--project=@nvim-lspconfig",
                  "-e",
                  "using LanguageServer; using SymbolServer; runserver()",
               },
               filetypes = { "julia" },
            },

            -- LaTeX
            texlab = {
               settings = {
                  texlab = {
                     latexindent = { modifyLineBreaks = true },
                  },
               },
            },

            -- Lua
            lua_ls = {
               settings = {
                  Lua = {
                     hint = { enable = true },
                     format = { enable = false },
                  },
               },
            },

            -- Rust
            rust_analyzer = {
               filetypes = { "rust" },
               root_markers = { "Cargo.toml" },
               settings = {
                  ["rust-analyzer"] = {
                     cargo = { allFeatures = true },
                  },
               },
            },

            -- TOML
            tombi = {},

            -- YAML
            yamlls = {},

            -- Zig
            zls = {},
         }

         -- Iterate over LSPs and apply global defaults
         for server_name, config in pairs(servers) do
            config.capabilities = lsp_capabilities
            config.on_attach = lsp_format_on_save

            vim.lsp.config(server_name, config)
            vim.lsp.enable(server_name)
         end

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
            end,
            desc = "Keymaps nvim-lspconfig (buffer-local)",
         })
      end,
   },
}
