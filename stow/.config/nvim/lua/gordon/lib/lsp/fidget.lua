local M = {}

M.setup = function()
  require("fidget").setup({
    notification = {
      window = {
        normal_hl = "Normal",
        winblend = 0,
      },
    },
  })
end

return M
