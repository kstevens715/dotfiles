function insert_ticket_token()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
  local prefix, ticket = string.match(branch, "(%a+)/(%u+%-%d+)")
  if prefix then
    local token = string.format("[%s]", ticket)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local found = false

    for _, line in ipairs(lines) do
      if string.find(line, token, 0, true) then
        found = true
        break
      end
    end

    if not found then
      vim.api.nvim_buf_set_option(0, "bufhidden", "delete")
      vim.api.nvim_buf_set_lines(0, 1, 1, false, {""})
      vim.api.nvim_buf_set_lines(0, 2, 2, false, {token})
    end
  end
end

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
vim.cmd [[autocmd BufEnter COMMIT_EDITMSG lua insert_ticket_token()]]
