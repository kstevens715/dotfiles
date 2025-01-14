local M = {
  'loctvl842/monokai-pro.nvim',
  lazy = false,
  priority = 1000,
}

function M.config()
  require('monokai-pro').setup({
    -- See palette: https://github.com/loctvl842/monokai-pro.nvim?tab=readme-ov-file#palette
    override = function(c)
      return {
          ['@keyword.type'] = { fg = c.base.red, italic = false },
          ['@keyword.function'] = { fg = c.base.red, italic = false },
          ['@string.special.symbol'] = { fg = c.base.magenta, italic = false },
        }
    end
  })
  vim.cmd.colorscheme 'monokai-pro'
end

return M
