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
            desc = "Keymaps nvim-dap (buffer-local)",
            callback =
               ---@param ev vim.api.keyset.create_autocmd.callback_args
               function(ev)
                  -- Buffer-local keymaps
                  local keymaps = require("core.keymaps")
                  local util = require("core.util")
                  util.map_keys(keymaps.nvim_dap, { buffer = ev.buf })
               end,
         })
      end,
   },

   -- Modern debugger UI with post-session inspection
   {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
      event = "LspAttach",
      config = function()
         local dap = require("dap")
         local dapui = require("dapui")
         dapui.setup()
         local session_active = false
         dap.listeners.after.event_initialized["dapui_config"] = function()
            session_active = true
            dapui.open()
         end
         local function notify_session_end()
            if session_active then
               session_active = false
            end
         end
         dap.listeners.before.event_terminated["dapui_config"] =
            notify_session_end
         dap.listeners.before.event_exited["dapui_config"] = notify_session_end
         local grp =
            vim.api.nvim_create_augroup("Nvim-DAP-UI", { clear = true })
         vim.api.nvim_create_autocmd("LspAttach", {
            group = grp,
            desc = "Keymaps nvim-dap-ui (buffer-local)",
            callback =
               ---@param ev vim.api.keyset.create_autocmd.callback_args
               function(ev)
                  -- Buffer-local keymaps
                  local keymaps = require("core.keymaps")
                  local util = require("core.util")
                  util.map_keys(keymaps.nvim_dap_ui, { buffer = ev.buf })
               end,
         })
      end,
   },

   -- Mason bridge for `nvim-dap`
   {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-dap" },
      event = "LspAttach",
      build = ":MasonUpdate",
      config = function()
         require("mason-nvim-dap").setup({
            automatic_installation = true,
            ensure_installed = {
               "codelldb",
               "delve",
               "python",
            },
            handlers = {},
         })
      end,
   },

   -- DAP for Python
   {
      "mfussenegger/nvim-dap-python",
      dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
      ft = "python",
      config = function()
         require("dap-python").setup()
         local grp =
            vim.api.nvim_create_augroup("Nvim-DAP-Python", { clear = true })
         vim.api.nvim_create_autocmd({ "LspAttach", "FileType" }, {
            group = grp,
            pattern = { "python" },
            desc = "Keymaps nvim-dap-python (buffer-local)",
            callback =
               ---@param ev vim.api.keyset.create_autocmd.callback_args
               function(ev)
                  -- Buffer-local keymaps
                  local keymaps = require("core.keymaps")
                  local util = require("core.util")
                  util.map_keys(keymaps.nvim_dap_python, { buffer = ev.buf })
               end,
         })
      end,
   },

   -- DAP for Go
   {
      "leoluz/nvim-dap-go",
      dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
      ft = "go",
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
               desc = "Keymaps nvim-dap-go (buffer-local)",
               callback =
                  ---@param ev vim.api.keyset.create_autocmd.callback_args
                  function(ev)
                     -- Buffer-local keymaps
                     local keymaps = require("core.keymaps")
                     local util = require("core.util")
                     util.map_keys(keymaps.nvim_dap_go, { buffer = ev.buf })
                  end,
            })
         end,
   },
}
