local M = {
  'folke/trouble.nvim',
}

function M.config()
  require('trouble').setup {
    icons = true,
    signs = {
      error = '',
      warning = '',
      hint = '',
      information = '',
      other = '﫠'
    },
  }
end

return M
