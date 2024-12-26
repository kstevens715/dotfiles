local M = {
  'rest-nvim/rest.nvim',
}

function M.config()
  vim.keymap.set('n', '<C-j>', '<cmd>Rest run<CR>', { desc = 'Run REST command' })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'json',
    callback = function (ev)
      vim.bo.formatexpr = ''
      vim.bo.formatprg = 'jq'
      vim.bo[ev.buf].filetype = 'json'
    end
  })
end

return M
