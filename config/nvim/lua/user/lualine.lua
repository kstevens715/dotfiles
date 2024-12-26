local M = {
  'nvim-lualine/lualine.nvim',
}

function M.config()

  local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed
      }
    end
  end

  require('lualine').setup {
    sections = {
      lualine_b = {
        {
          'diff',
          source = diff_source
        },
      },
      lualine_c = {
        {
          'filename',
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1,           -- 0 = just filename, 1 = relative path, 2 = absolute path
        }
      },
    }
  }
end

return M
