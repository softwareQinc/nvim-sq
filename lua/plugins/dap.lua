return {
   -- DAP
   {
      "mfussenegger/nvim-dap",
      event = "LspAttach",
      config = function()
         vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("DAP", {}),
            callback = function(ev)
               -- Buffer local mappings.
               -- See `:help vim.lsp.*` for documentation on any of the below util
               local bindings = require("core.bindings")
               local util = require("core.util")
               util.map_keys(bindings.nvim_dap, { buffer = ev.buf })
            end,
         })
      end,
   },
   -- additional UI to make the debugger prettier
   {
      "rcarriga/nvim-dap-ui",
      event = "LspAttach",
      dependencies = "mfussenegger/nvim-dap",
      config = function()
         local dap = require("dap")
         local dapui = require("dapui")
         dapui.setup()
         dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
         end
         dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
         end
         dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
         end
      end,
   },
   -- DAP for Mason
   {
      "jay-babu/mason-nvim-dap.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      dependencies = {
         "williamboman/mason.nvim",
         "mfussenegger/nvim-dap",
      },
      opts = {
         handlers = {},
      },
   },
   -- DAP for Python
   {
      "mfussenegger/nvim-dap-python",
      ft = "python",
      dependencies = {
         "mfussenegger/nvim-dap",
         "rcarriga/nvim-dap-ui",
      },
      config = function(_, _)
         vim.api.nvim_create_autocmd({ "LspAttach", "FileType" }, {
            group = vim.api.nvim_create_augroup("DAP-Python", {}),
            pattern = "python",
            callback = function(ev)
               -- Buffer local mappings.
               -- See `:help vim.lsp.*` for documentation on any of the below util
               local bindings = require("core.bindings")
               local util = require("core.util")
               util.map_keys(bindings.nvim_dap_python, { buffer = ev.buf })
            end,
         })
      end,
   },
   -- DAP for Go
   {
      "leoluz/nvim-dap-go",
      ft = "go",
      dependencies = {
         "mfussenegger/nvim-dap",
         "rcarriga/nvim-dap-ui",
      },
      config = function(_, opts)
         require("dap-go").setup(opts)
         vim.api.nvim_create_autocmd({ "LspAttach", "FileType" }, {
            group = vim.api.nvim_create_augroup("DAP-Go", {}),
            pattern = "go",
            callback = function(ev)
               -- Buffer local mappings.
               -- See `:help vim.lsp.*` for documentation on any of the below util
               local bindings = require("core.bindings")
               local util = require("core.util")
               util.map_keys(bindings.nvim_dap_go, { buffer = ev.buf })
            end,
         })
      end,
   },
}
