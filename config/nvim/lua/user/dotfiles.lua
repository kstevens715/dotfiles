local M = {}

function M.insert_ticket_token()
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

function M.git_notes_filename()
  local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD')
  branch = string.gsub(branch, '\n', '')
  local filename = "~/Documents/git-notes/" .. vim.fn.substitute(branch, '/', '_', 'g') .. '.md'

  return vim.fn.fnameescape(filename)
end

function M.open_markdown_file_from_git_branch()
  local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD')
  branch = string.gsub(branch, '\n', '')
  local filename = "~/Documents/git-notes/" .. vim.fn.substitute(branch, '/', '_', 'g') .. '.md'
  vim.api.nvim_command('edit ' .. M.git_notes_filename())
  vim.bo.filetype = 'markdown'
end

function M.run_last_command()
  vim.api.nvim_command('Texec !bundle \n')
end

return M
