---@type LazyPluginSpec
return {
   "openqasm/openqasm.vim",
   ft = { "openqasm" },
   init = function()
      -- OpenQASM falls back to version 2.0
      vim.g.openqasm_version_fallback = 2.0
      -- vim.g.openqasm_version_override = 2.0
   end,
}
