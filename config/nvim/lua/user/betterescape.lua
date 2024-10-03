local M = {
  'max397574/better-escape.nvim',
  tag = 'v1.0.0',
}

function M.config()
  require('better_escape').setup()
end

return M
