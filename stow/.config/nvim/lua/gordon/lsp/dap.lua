local M = {}

M.setup = function ()
  require('dapui').setup()

  vim.keymap.set('n', '<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<cr>')
  vim.keymap.set('n', '<leader>dc', '<cmd>lua require("dap").continue()<cr>')
  vim.keymap.set('n', '<leader>di', '<cmd>lua require("dap").step_into()<cr>')
  vim.keymap.set('n', '<leader>do', '<cmd>lua require("dap").step_over()<cr>')
  vim.keymap.set('n', '<leader>du', '<cmd>lua require("dap").step_out()<cr>')
  vim.keymap.set('n', '<leader>dr', '<cmd>lua require("dap").repl.open()<cr>')
  vim.keymap.set('n', '<leader>dl', '<cmd>lua require("dap").run_last()<cr>')
  vim.keymap.set('n', '<leader>dt', '<cmd>lua require("dapui").toggle()<cr>')
end

return M
