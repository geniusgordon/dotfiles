require("telescope").setup({
  extensions = {
    coc = {
        prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
    }
  },
})
