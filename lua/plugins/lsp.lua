---@type LazySpec
return {
   -- Manages DAPs, language servers, linters, and formatters
   -- We use mason-lspconfig for language servers, and Mason only for DAPs,
   -- linters and formatters
   {
      "mason-org/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonUpdate" },
      opts = {},
   },

   -- Linters and formatters ONLY. DO NOT add LSP servers or DAPs here.
   -- LSPs are installed later in this file, see mason-lsp-config:setup({...})
   -- DAPs are installed in "dap.lua", see mason-nvim-dap:setup({...})
   {
      "jay-babu/mason-null-ls.nvim",
      dependencies = { "mason-org/mason.nvim", "nvimtools/none-ls.nvim" },
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
      "mason-org/mason-lspconfig.nvim",
      dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
      opts = {
         -- LSPs that are installed by default
         ensure_installed = {
            "basedpyright", -- Python
            "bashls", -- Bash/sh
            "clangd", -- C, C++
            "cmake", -- C, C++ build system
            "eslint", -- JavaScript/TypeScript
            "gopls", -- Go
            -- "hls", -- Haskell, not needed, we use haskell-tools
            -- Do not install julials via Mason
            -- https://discourse.julialang.org/t/neovim-languageserver-jl-crashing-again/130273
            -- "julials",
            "lua_ls", -- Lua
            "marksman", -- Markdown
            "tombi", -- TOML
            "ruff", -- Python
            "rust_analyzer", -- Rust
            "texlab", -- LaTeX
            "ts_ls", -- JavaScript/TypeScript
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

         -- TODO: Migrate to the native Neovim 0.11+ LSP autocompletion
         lsp_capabilities = vim.tbl_deep_extend(
            "force",
            lsp_capabilities,
            require("cmp_nvim_lsp").default_capabilities()
         )

         -- Configure the servers
         local servers = {
            -- Servers that do not require custom settings
            basedpyright = {}, -- Python
            bashls = {}, -- Bash/sh
            cmake = {}, -- CMake
            marksman = {}, -- Markdown
            ruff = {}, -- Python
            tombi = {}, -- TOML
            ts_ls = {}, -- JavaScript/TypeScript
            vimls = {}, -- Vim script
            yamlls = {}, -- YAML
            zls = {}, -- Zig

            -- Servers that require custom settings
            -- C, C++
            clangd = {
               cmd = {
                  "clangd",
                  "--header-insertion=never",
                  "--offset-encoding=utf-16",
               },
            },

            -- JavaScript/TypeScript
            eslint = {
               filetypes = {
                  "javascript",
                  "javascript.jsx",
                  "javascriptreact",
                  "svelte",
                  "typescript",
                  "typescript.tsx",
                  "typescriptreact",
                  "vue",
               },
               settings = {
                  workingDirectory = { mode = "auto" },
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

            -- Lua
            lua_ls = {
               settings = {
                  Lua = {
                     hint = { enable = true },
                     format = { enable = false },
                     -- FIXME: See https://github.com/folke/lazydev.nvim/issues/136
                     workspace = {
                        checkThirdParty = false,
                        library = {
                           vim.env.VIMRUNTIME,
                           {
                              path = "${3rd}/luv/library",
                              words = { "vim%.uv" },
                           },
                        },
                     },
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

            -- LaTeX
            texlab = {
               settings = {
                  texlab = {
                     latexindent = { modifyLineBreaks = true },
                  },
               },
            },
         }

         -- Iterate over LSPs and apply global defaults
         for server_name, config in pairs(servers) do
            config.capabilities = lsp_capabilities
            config.on_attach = lsp_format_on_save

            vim.lsp.config(server_name, config)
            vim.lsp.enable(server_name)
         end

         -- Additional settings
         local lsp_group =
            vim.api.nvim_create_augroup("Nvim-lspconfig", { clear = true })
         vim.api.nvim_create_autocmd("LspAttach", {
            group = lsp_group,
            callback =
               ---@param ev vim.api.keyset.create_autocmd.callback_args
               function(ev)
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

                  -- Inlay hints policy (buffer overrides global)
                  if vim.lsp.inlay_hint then
                     local bufnr = ev.buf
                     if vim.b[bufnr].inlay_hints_enabled ~= nil then
                        -- Buffer override wins (even if false)
                        vim.lsp.inlay_hint.enable(
                           vim.b[bufnr].inlay_hints_enabled,
                           { bufnr = bufnr }
                        )
                     elseif vim.g.inlay_hints_enabled ~= nil then
                        -- Apply global only if explicitly set; default stays
                        -- untouched otherwise
                        vim.lsp.inlay_hint.enable(
                           vim.g.inlay_hints_enabled == true,
                           { bufnr = bufnr }
                        )
                     end
                  end
               end,
            desc = "Keymaps nvim-lspconfig (buffer-local)",
         })
      end,
   },
}
