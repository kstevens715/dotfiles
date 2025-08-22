local M = {
  "EdenEast/nightfox.nvim", -- lazy
  lazy = false,
  priority = 1000,
}

function M.config()
  require('nightfox').setup({
  })
  vim.cmd.colorscheme 'dayfox'
end

return M
