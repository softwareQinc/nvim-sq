---@type LazyPluginSpec
return {
   -- Auto completion
   "hrsh7th/nvim-cmp",
   event = { "InsertEnter" },
   dependencies = {
      -- Snippet plugin
      {
         "L3MON4D3/LuaSnip",
         -- Follow latest release.
         -- Replace <CurrentMajor> by the latest released major (first
         -- number of latest release)
         version = "*",
         dependencies = { "rafamadriz/friendly-snippets" },
         opts = {
            history = true,
            updateevents = "TextChanged,TextChangedI",
         },
         -- install jsregexp (optional!).
         build = "make install_jsregexp",
      },
      -- Nice LSP completion symbols
      {
         "onsails/lspkind.nvim",
      },
      -- Autopairing of (){}[] etc
      {
         "windwp/nvim-autopairs",
         opts = {
            fast_wrap = {},
            disable_filetype = { "TelescopePrompt", "vim" },
         },
         config =
            ---@param _ LazyPlugin
            ---@param opts table
            function(_, opts)
               require("nvim-autopairs").setup(opts)

               -- Setup cmp for autopairs
               local cmp_autopairs = require("nvim-autopairs.completion.cmp")
               require("cmp").event:on(
                  "confirm_done",
                  cmp_autopairs.on_confirm_done()
               )
            end,
      },
      -- cmp sources plugins
      {
         "saadparwaiz1/cmp_luasnip",
         "hrsh7th/cmp-nvim-lua",
         "hrsh7th/cmp-nvim-lsp", -- TODO: Switch to the native nvim 0.11+ LSP autocompletion
         "hrsh7th/cmp-nvim-lsp-signature-help",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
      },
      -- Additional auto completion, command line
      {
         "hrsh7th/cmp-cmdline",
         event = "CmdlineEnter",
         dependencies = { "hrsh7th/cmp-buffer" },
         config = function()
            local cmp = require("cmp")
            -- `/` cmdline setup.
            cmp.setup.cmdline("/", {
               mapping = cmp.mapping.preset.cmdline(),
               sources = {
                  { name = "buffer" },
               },
            })
            -- `:` cmdline setup.
            cmp.setup.cmdline(":", {
               mapping = cmp.mapping.preset.cmdline(),
               sources = cmp.config.sources({
                  {
                     name = "path",
                     option = { trailing_slash = true },
                  },
               }, {
                  {
                     name = "cmdline",
                     option = {
                        ignore_cmds = { "Man", "!" },
                        treat_trailing_slash = false,
                     },
                  },
               }),
            })
         end,
      },
   },
   config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      -- VSCode format
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Snippets
      local config_path = vim.fn.stdpath("config")
      require("luasnip.loaders.from_lua").load({
         paths = { config_path .. "/lua/snippets" },
      })

      cmp.setup({
         sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "nvim_lsp_signature_help" },
            { name = "nvim_lua" },
            { name = "luasnip" },
         }, {
            { name = "buffer" },
         }),
         formatting = {
            fields = { "abbr", "kind", "menu" },
            expandable_indicator = true,
            format = lspkind.cmp_format({
               mode = "symbol_text",
               menu = {
                  nvim_lsp = "[LSP]",
                  nvim_lsp_signature_help = "[LSP sig]",
                  nvim_lua = "[API]",
                  luasnip = "[LuaSnip]",
                  buffer = "[Buffer]",
                  path = "[Path]",
                  cmdline = "[Cmd]",
               },
            }),
         },
         snippet = {
            expand =
               ---@param args cmp.SnippetExpansionParams
               function(args)
                  require("luasnip").lsp_expand(args.body)
               end,
         },
         window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
         },
         mapping = cmp.mapping.preset.insert({
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-n>"] = cmp.mapping(
               ---@param fallback fun()
               function(fallback)
                  if cmp.visible() then
                     cmp.select_next_item()
                  elseif luasnip.expand_or_jumpable() then
                     luasnip.expand_or_jump()
                  else
                     fallback()
                  end
               end,
               { "i", "s" }
            ),
            ["<C-p>"] = cmp.mapping(
               ---@param fallback fun()
               function(fallback)
                  if cmp.visible() then
                     cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                     luasnip.jump(-1)
                  else
                     fallback()
                  end
               end,
               { "i", "s" }
            ),
         }),
      })
   end,
}
