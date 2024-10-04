local M = {
  'max397574/better-escape.nvim',
}

function M.config()
  require('better_escape').setup {
    mappings = {
      i = {
        j = {
          k = "<Esc>",
          j = "<Esc>",
        },
      },
      c = {
        j = {
          k = "<Esc>",
          j = "<Esc>",
        },
      },
      t = {
        j = {
          k = "<C-\\><C-n>",
        },
      },
      v = {
        j = {
          k = false,
        },
      },
      s = {
        j = {
          k = "<Esc>",
        },
      },
    }
  }
end

return M
