local M = {}

M.setup = function()
  require("CopilotChat").setup({
    model = "claude-3.7-sonnet",
  })

  local opts = { noremap = true, silent = true }
  local keymap = vim.keymap.set

  -- Toggle chat window
  keymap("n", "<leader>cc", "<cmd>CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat", unpack(opts) })
  -- Open chat window
  keymap("n", "<leader>co", "<cmd>CopilotChatOpen<CR>", { desc = "Open Copilot Chat", unpack(opts) })
  -- Close chat window
  keymap("n", "<leader>cx", "<cmd>CopilotChatClose<CR>", { desc = "Close Copilot Chat", unpack(opts) })
  keymap("n", "<leader>cm", "<cmd>CopilotChatCommit<CR>", { desc = "Write Commit Message", unpack(opts) })
  -- Prompt templates
  keymap("v", "<leader>ce", "<cmd>CopilotChatExplain<CR>", { desc = "Explain Code", unpack(opts) })
  keymap("v", "<leader>cr", "<cmd>CopilotChatReview<CR>", { desc = "Review Code", unpack(opts) })
  keymap("v", "<leader>cf", "<cmd>CopilotChatFix<CR>", { desc = "Fix Code", unpack(opts) })
  keymap("v", "<leader>co", "<cmd>CopilotChatOptimize<CR>", { desc = "Optimize Code", unpack(opts) })
  keymap("v", "<leader>cd", "<cmd>CopilotChatDocs<CR>", { desc = "Add Documentation", unpack(opts) })
  keymap("v", "<leader>ct", "<cmd>CopilotChatTests<CR>", { desc = "Generate Tests", unpack(opts) })
  keymap("v", "<leader>cm", "<cmd>CopilotChatCommit<CR>", { desc = "Write Commit Message", unpack(opts) })
end

return M
