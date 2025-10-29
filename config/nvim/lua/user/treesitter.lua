local M = {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  build = ":TSUpdate",
  dependencies = {
    'RRethy/nvim-treesitter-endwise',
    'nvim-treesitter/playground',
  }
}


function M.config()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'bash', 'comment', 'css', 'dockerfile', 'html', 'http', 'javascript', 'json', 'lua', 'markdown', 'python', 'ruby', 'scss', 'scheme', 'vim', 'vimdoc', 'vue', 'xml', 'yaml' },
    endwise = { enable = true },
    highlight = { enable = true },
    indent = { enable = false },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_hl_groups = 'i',
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<CR>',
        scope_incremental = '<CR>',
        node_incremental = '<TAB>',
        node_decremental = '<S-TAB>',
      },
    },
  }
end

return M
