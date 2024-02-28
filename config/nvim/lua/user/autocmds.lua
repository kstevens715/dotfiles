local dotfiles = require('user.dotfiles')

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.tsx,*.ts,*.jsx,*.js,*.vue',
  callback = function(args)
    vim.cmd('EslintFixAll')
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.rb',
  callback = function(args)
    if not string.match(args.file, "spec%.rb$") and not string.match(args.file, "routes.rb$") and not string.match(args.file, "application.rb$") and not string.match(args.file, "environments")  then
      vim.lsp.buf.format()
    end
  end,
})

vim.cmd 'autocmd BufRead,BufNewFile *.scm set filetype=scheme'
vim.cmd [[autocmd BufEnter COMMIT_EDITMSG lua require('user.dotfiles').insert_ticket_token()]]
