local M = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', lazy = true },
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
}

function M.config()
  require('telescope').load_extension('fzf')
  require('telescope.builtin')

  require('telescope').setup {
    pickers = {
      colorscheme = {
        enable_preview = true
      }
    }
  }
end

return M
