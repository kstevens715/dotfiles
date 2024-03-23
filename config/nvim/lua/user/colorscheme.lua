local M = {
  'mcchrish/zenbones.nvim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  dependencies = {
    {
      'rktjmp/lush.nvim',
    },
  },
}

function M.config()
  vim.cmd.colorscheme 'zenbones'
  vim.o.background = 'light'
end

return M
