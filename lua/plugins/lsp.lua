return {
   -- Manage (installs/removes etc.) DAPs, language servers, linters, and formatters
   -- We use mason-lspconfig for language servers, and Mason only for DAPs, linters and formatters
   {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
      config = function()
         require("mason").setup()
         -- DAP, linters, and formatters. Do not add LSP servers here
         local ensure_installed = {
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
            "ruff",
            "shellcheck",
            "cmake-language-server",
            "cmakelang",
            "cmakelint",
            "mypy",

            -- Debuggers
            "codelldb",
            "debugpy",
         }
         -- Custom NVChad cmd to install all Mason binaries listed in ensure_installed table
         vim.api.nvim_create_user_command("MasonEnsureInstalled", function()
            if ensure_installed and #ensure_installed > 0 then
               vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
            end
         end, {})
         -- vim.g.mason_binaries_list = ensure_installed
      end,
   },
   -- Manage (installs/removes etc.) language servers only
   {
      "williamboman/mason-lspconfig.nvim",
      config = function()
         -- Setup neodev BEFORE the first require("lspconfig")
         require("neodev").setup({})

         local lspconfig = require("lspconfig")
         local util = require("lspconfig.util")
         local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
         lsp_capabilities =
            vim.tbl_deep_extend("force", lsp_capabilities, require("cmp_nvim_lsp").default_capabilities())

         local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
         local lsp_format_on_save = require("core.util").format_on_save(augroup)

         local default_setup = function(server)
            lspconfig[server].setup({
               capabilities = lsp_capabilities,
               on_attach = lsp_format_on_save,
            })
         end

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
               "ruff_lsp",
               "cmake",
               "rust_analyzer",
               "marksman",
               "gopls",
               "hls",
            },
            handlers = {
               default_setup,
               -- Custom configuration below
               clangd = function()
                  lspconfig.clangd.setup({
                     capabilities = lsp_capabilities,
                     on_attach = lsp_format_on_save,
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
                     filetypes = { "rust" },
                     root_dir = util.root_pattern("Cargo.toml"),
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
                     cmd = { "gopls" },
                     filetypes = { "go", "gomod", "gowork", "gotmpl" },
                     root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                     settings = {
                        gopls = {
                           completeUnimported = true,
                           usePlaceholders = true,
                           analyses = {
                              unusedparams = true,
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
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(ev)
               -- Disable semantic token highlighting for lua_ls
               local client = vim.lsp.get_client_by_id(ev.data.client_id)
               if client.name == "lua_ls" then
                  client.server_capabilities.semanticTokensProvider = nil
               end
               -- Enable completion triggered by <c-x><c-o>
               vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
               -- Buffer local mappings.
               -- See `:help vim.lsp.*` for documentation on any of the below util
               local bindings = require("core.bindings")
               local util = require("core.util")
               util.map_keys(bindings.nvim_lspconfig, { buffer = ev.buf })
            end,
         })
      end,
   },
}
