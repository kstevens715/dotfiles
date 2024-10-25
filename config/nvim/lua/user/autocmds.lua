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
