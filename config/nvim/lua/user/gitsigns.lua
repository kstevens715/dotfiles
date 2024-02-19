local M = {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  }
}

function M.config()
  require('gitsigns').setup()
end

return M
