local M = {}

M.setup = function()
  local dap = require("dap")
  local dapui = require("dapui")
  dapui.setup()

  vim.keymap.set("n", "<leader>db", function()
    dap.toggle_breakpoint()
  end, { desc = "Toggle breakpoint" })

  vim.keymap.set("n", "<leader>dc", function()
    dap.continue()
  end, { desc = "Continue" })

  vim.keymap.set("n", "<leader>di", function()
    dap.step_into()
  end, { desc = "Step into" })

  vim.keymap.set("n", "<leader>do", function()
    dap.step_over()
  end, { desc = "Step over" })

  vim.keymap.set("n", "<leader>du", function()
    dap.step_out()
  end, { desc = "Step out" })

  vim.keymap.set("n", "<leader>dr", function()
    dap.repl.open()
  end, { desc = "Open REPL" })

  vim.keymap.set("n", "<leader>dl", function()
    dap.run_last()
  end, { desc = "Run last" })

  vim.keymap.set("n", "<leader>dt", function()
    dapui.toggle()
  end, { desc = "Toggle DAP UI" })
end

return M
