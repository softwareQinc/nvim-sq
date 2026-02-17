---@type LazySpec
return {
   -- Core DAP (Debug Adapter Protocol) configuration
   {
      "mfussenegger/nvim-dap",
      event = "LspAttach",
      config = function()
         local grp = vim.api.nvim_create_augroup("Nvim-DAP", { clear = true })
         vim.api.nvim_create_autocmd("LspAttach", {
            group = grp,
            callback =
               ---@param ev vim.api.keyset.create_autocmd.callback_args
               function(ev)
                  -- Buffer-local keymaps
                  local keymaps = require("core.keymaps")
                  local util = require("core.util")
                  util.map_keys(keymaps.nvim_dap, { buffer = ev.buf })
               end,
            desc = "Keymaps nvim-dap (buffer-local)",
         })
      end,
   },

   -- Additional DAP UI to make the debugger prettier
   {
      "rcarriga/nvim-dap-ui",
      event = "LspAttach",
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
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

   -- DAP integration via Mason
   {
      "jay-babu/mason-nvim-dap.nvim",
      event = "LspAttach",
      dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-dap" },
      opts = {
         automatic_installation = true,
         ensure_installed = {
            "codelldb",
            "delve",
            "python",
         },
         handlers = {},
      },
   },

   -- DAP for Python
   {
      "mfussenegger/nvim-dap-python",
      ft = "python",
      dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },

      config =
         ---@param _plugin LazyPlugin
         ---@param _opts table
         ---@diagnostic disable-next-line: unused-local
         function(_plugin, _opts)
            require("dap-python").setup()
            local grp =
               vim.api.nvim_create_augroup("Nvim-DAP-Python", { clear = true })

            vim.api.nvim_create_autocmd({ "LspAttach", "FileType" }, {
               group = grp,
               pattern = { "python" },
               callback =
                  ---@param ev vim.api.keyset.create_autocmd.callback_args
                  function(ev)
                     -- Buffer-local keymaps
                     local keymaps = require("core.keymaps")
                     local util = require("core.util")
                     util.map_keys(keymaps.nvim_dap_python, { buffer = ev.buf })
                  end,
               desc = "Keymaps nvim-dap-python (buffer-local)",
            })
         end,
   },

   -- DAP for Go
   {
      "leoluz/nvim-dap-go",
      ft = "go",
      dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
      config =
         ---@param _ LazyPlugin
         ---@param opts table
         function(_, opts)
            require("dap-go").setup(opts)
            local grp =
               vim.api.nvim_create_augroup("Nvim-DAP-Go", { clear = true })
            vim.api.nvim_create_autocmd({ "LspAttach", "FileType" }, {
               group = grp,
               pattern = { "go" },
               callback =
                  ---@param ev vim.api.keyset.create_autocmd.callback_args
                  function(ev)
                     -- Buffer-local keymaps
                     local keymaps = require("core.keymaps")
                     local util = require("core.util")
                     util.map_keys(keymaps.nvim_dap_go, { buffer = ev.buf })
                  end,
               desc = "Keymaps nvim-dap-go (buffer-local)",
            })
         end,
   },
}
