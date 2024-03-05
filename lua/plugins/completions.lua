return {
   {
      -- Auto completion
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter" },
      dependencies = {
         {
            -- Snippet plugin
            "L3MON4D3/LuaSnip",
            -- Follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            dependencies = "rafamadriz/friendly-snippets",
            opts = { history = true, updateevents = "TextChanged,TextChangedI" },
         },
         -- Autopairing of (){}[] etc
         {
            "windwp/nvim-autopairs",
            opts = {
               fast_wrap = {},
               disable_filetype = { "TelescopePrompt", "vim" },
            },
            config = function(_, opts)
               require("nvim-autopairs").setup(opts)

               -- Setup cmp for autopairs
               local cmp_autopairs = require("nvim-autopairs.completion.cmp")
               require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end,
         },
         -- cmp sources plugins
         {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
         },
         -- Additional auto completion, command line
         {
            "hrsh7th/cmp-cmdline",
            event = "CmdlineEnter",
            dependencies = {
               "hrsh7th/cmp-buffer",
            },
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
                     { name = "path" },
                  }, {
                     {
                        name = "cmdline",
                        option = {
                           ignore_cmds = { "Man", "!" },
                        },
                     },
                  }),
               })
            end,
         },
      },

      config = function()
         local cmp = require("cmp")
         -- vscode format
         require("luasnip.loaders.from_vscode").lazy_load()
         cmp.setup({
            snippet = {
               expand = function(args)
                  require("luasnip").lsp_expand(args.body)
               end,
            },
            window = {
               completion = cmp.config.window.bordered(),
               documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
               ["<C-b>"] = cmp.mapping.scroll_docs(-4),
               ["<C-f>"] = cmp.mapping.scroll_docs(4),
               ["<C-Space>"] = cmp.mapping.complete(),
               ["<C-e>"] = cmp.mapping.abort(),
               ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
               { name = "nvim_lsp" },
               { name = "luasnip" },
            }, {
               { name = "buffer" },
            }),
         })

         -- Set configuration for specific filetype.
         cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
               { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
               { name = "buffer" },
            }),
         })
      end,
   },
}
