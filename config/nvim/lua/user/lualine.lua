local M = {
  'nvim-lualine/lualine.nvim',
}

function M.config()
  require('lualine').setup {
    options = { theme = 'sonokai' },
    sections = {
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
