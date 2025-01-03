local M = {
    'zenbones-theme/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
}


function M.config()
  vim.cmd.colorscheme 'zenbones'
end

return M
