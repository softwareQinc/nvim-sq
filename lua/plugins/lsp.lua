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
            "stylua",
            "gofumpt",
            "goimports-reviser",
            "golines",
            "latexindent",
            "shfmt",
            "prettier",

            -- Linters
            "shellcheck",
            "cmake-language-server",
            "cmakelang",
            "cmakelint",
            "mypy",
         },
      },
   },
   -- Manages (installs/removes etc.) language servers only
   {
      "williamboman/mason-lspconfig.nvim",
      config = function()
         -- Setup neodev BEFORE the first require("lspconfig")
         ---@diagnostic disable-next-line: missing-fields
         require("neodev").setup({})

         local lspconfig = require("lspconfig")
         local lspconfig_util = require("lspconfig.util")

         local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
         lsp_capabilities = vim.tbl_deep_extend(
            "force",
            lsp_capabilities,
            require("cmp_nvim_lsp").default_capabilities()
         )

         local augroup =
            vim.api.nvim_create_augroup("LSP-formatting", { clear = true })
         local util = require("core.util")
         local lsp_format_on_save = util.format_on_save(augroup)

         -- Add the border on hover and on signature help popup window
         local lsp_handlers = {
            ["textDocument/hover"] = vim.lsp.with(
               vim.lsp.handlers.hover,
               { border = "rounded" }
            ),
            ["textDocument/signatureHelp"] = vim.lsp.with(
               vim.lsp.handlers.signature_help,
               { border = "rounded" }
            ),
         }

         -- Default server setup
         local function default_setup(server)
            lspconfig[server].setup({
               capabilities = lsp_capabilities,
               on_attach = lsp_format_on_save,
               handlers = lsp_handlers,
            })
         end

         ---@diagnostic disable-next-line: missing-fields
         require("mason-lspconfig").setup({
            -- LSP servers
            ensure_installed = {
               "lua_ls",
               "clangd",
               "rust_analyzer",
               "julials",
               "bashls",
               "texlab",
               "pyright",
               "ruff",
               "cmake",
               "marksman",
               "gopls",
               "vimls",
               -- "hls", -- not needed, we use haskell-tools.nvim
            },
            handlers = {
               default_setup,

               -- Custom configurations below
               lua_ls = function()
                  lspconfig.lua_ls.setup({
                     capabilities = lsp_capabilities,
                     on_attach = lsp_format_on_save,
                     handlers = lsp_handlers,
                     settings = {
                        Lua = {
                           hint = { enable = true },
                           -- We use none-ls stylua
                           format = {
                              enable = false,
                           },
                        },
                     },
                  })
               end,

               clangd = function()
                  lspconfig.clangd.setup({
                     capabilities = lsp_capabilities,
                     on_attach = lsp_format_on_save,
                     handlers = lsp_handlers,
                     cmd = {
                        "clangd",
                        "--header-insertion=never",
                        "--offset-encoding=utf-16",
                     },
                  })
               end,

               rust_analyzer = function()
                  lspconfig.rust_analyzer.setup({
                     capabilities = lsp_capabilities,
                     on_attach = lsp_format_on_save,
                     handlers = lsp_handlers,
                     filetypes = { "rust" },
                     root_dir = lspconfig_util.root_pattern("Cargo.toml"),
                     settings = {
                        ["rust-analyzer"] = {
                           cargo = {
                              allFeatures = true,
                           },
                        },
                     },
                  })
               end,

               gopls = function()
                  lspconfig.gopls.setup({
                     capabilities = lsp_capabilities,
                     on_attach = lsp_format_on_save,
                     handlers = lsp_handlers,
                     cmd = { "gopls" },
                     filetypes = { "go", "gomod", "gowork", "gotmpl" },
                     root_dir = lspconfig_util.root_pattern(
                        "go.work",
                        "go.mod",
                        ".git"
                     ),
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
               end,

               texlab = function()
                  lspconfig.texlab.setup({
                     capabilities = lsp_capabilities,
                     on_attach = lsp_format_on_save,
                     handlers = lsp_handlers,
                     settings = {
                        texlab = {
                           latexindent = {
                              modifyLineBreaks = true,
                           },
                        },
                     },
                  })
               end,
            },
         })
      end,
   },
   -- LSP (Language Server Protocol), automatically configured by lsp-zero
   {
      "neovim/nvim-lspconfig",
      event = "LspAttach",
      config = function()
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
               local util = require("core.util")
               util.map_keys(keymaps.nvim_lspconfig, { buffer = ev.buf })
            end,
            desc = "Keymaps nvim-lspconfig (buffer-local)",
         })
      end,
   },
}
