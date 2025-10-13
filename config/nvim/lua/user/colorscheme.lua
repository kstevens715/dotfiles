local M = {
  'loctvl842/monokai-pro.nvim',
  lazy = false,
  priority = 1000,
}

function M.config()
  vim.cmd.colorscheme 'monokai-pro'
end

return M
