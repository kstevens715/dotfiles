local dotfiles = require('user.dotfiles')

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.tsx,*.ts,*.jsx,*.js,*.vue',
  callback = function(args)
    vim.cmd('EslintFixAll')
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.json,*.rb',
  callback = function(args)
    if vim.b.disable_autoformat then
      return
    end

    vim.lsp.buf.format()
  end,
})

vim.api.nvim_create_user_command('W', function()
  vim.b.disable_autoformat = true
  vim.cmd('write')
  vim.b.disable_autoformat = false
end, {})

vim.cmd 'autocmd BufRead,BufNewFile *.scm set filetype=scheme'
vim.cmd [[autocmd BufEnter COMMIT_EDITMSG lua require('user.dotfiles').insert_ticket_token()]]

-- Auto-reload files changed outside of Neovim
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  callback = function()
    if vim.fn.getcmdwintype() == '' then
      vim.cmd('checktime')
    end
  end,
})

-- Poll for changes every 2 seconds (even without focus)
local autoread_timer = vim.loop.new_timer()
autoread_timer:start(2000, 2000, vim.schedule_wrap(function()
  if vim.fn.getcmdwintype() == '' then
    vim.cmd('checktime')
  end
end))
