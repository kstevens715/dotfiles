-- Options, keymaps, autocmds, and aliases

local keymap = vim.keymap.set

-------------------------------------------------------------------------------
-- Options
-------------------------------------------------------------------------------

vim.g.html_number_lines = 0
vim.g.neoterm_autoscroll = 1
vim.g.neoterm_default_mod = 'botright vertical'
vim.g.neoterm_size = 100
vim.g.ruby_indent_assignment_style = 'variable'
vim.g['test#ruby#rspec#options'] = { all = '--format progress --order random' }
vim.g['test#ruby#use_binstubs'] = 0
vim.g['test#strategy'] = 'neoterm'

vim.o.autoread = true
vim.o.clipboard = 'unnamed'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 15
vim.o.foldmethod = "expr"
vim.o.ignorecase = true
vim.o.inccommand = 'nosplit'
vim.o.mouse = 'a'
vim.o.shiftwidth = 2
vim.o.showtabline = 1
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.wrap = false
vim.wo.number = true
vim.opt.spell = true
vim.opt.spelloptions = 'camel'
vim.opt.spelllang = 'en_us'

-------------------------------------------------------------------------------
-- Dotfiles utilities
-------------------------------------------------------------------------------

local dotfiles = {}

function dotfiles.insert_ticket_token()
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

function dotfiles.git_notes_filename()
  local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD')
  branch = string.gsub(branch, '\n', '')
  local filename = "~/Documents/git-notes/" .. vim.fn.substitute(branch, '/', '_', 'g') .. '.md'
  return vim.fn.fnameescape(filename)
end

function dotfiles.open_markdown_file_from_git_branch()
  local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD')
  branch = string.gsub(branch, '\n', '')
  vim.api.nvim_command('edit ' .. dotfiles.git_notes_filename())
  vim.bo.filetype = 'markdown'
end

function dotfiles.run_last_command()
  vim.api.nvim_command('Texec !bundle \n')
end

-------------------------------------------------------------------------------
-- Keymaps
-------------------------------------------------------------------------------

-- Leader mappings
keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { desc = 'View Buffers' })
keymap('n', '<leader>c', [[<cmd>Git<CR>]], { desc = 'Git Commit' })
keymap('n', '<leader>f', function()
  require('telescope.builtin').live_grep({
    additional_args = function()
      return {
        "--glob", "!Gemfile.lock",
        "--glob", "!Rakefile",
        "--glob", "!bin/**",
        "--glob", "!public/**",
        "--glob", "!spec/**",
        "--glob", "!swagger/**",
        "--glob", "!yarn.lock",
      }
    end
  })
end, { desc = 'Search Project and Exclude Files' })
keymap('n', '<leader>x', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { desc = 'Search Project Across all Files' })
keymap('n', '<leader>h', [[<cmd>Telescope git_bcommits<CR>]], { desc = 'Git History' })
keymap('n', '<leader>l', [[<cmd>! flog %<CR>]], { desc = 'Flog (ABC) Score' })
keymap('n', '<leader>r', [[<cmd>lua require('telescope.builtin').registers()<CR>]], { desc = 'Registers' })
keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { desc = 'Find Files' })
keymap('v', '<leader>s', [[:'<,'>sort<CR>]], { desc = 'Sort Lines' })

-- Double-key mappings
keymap('n', '<leader>ve', [[<cmd>e ~/dotfiles/config/nvim/init.lua<CR>]], { desc = 'Edit Vim Config' })
keymap('n', '<leader>vr', [[<cmd>source ~/dotfiles/config/nvim/init.lua<CR>]], { desc = 'Reload Vim Config' })
keymap('n', '<leader>wm', [[<cmd>e ~/Documents/working_memory.md<CR>]], { desc = 'Open Working Memory' })
keymap('n', '<leader>wp', [[<cmd>e ~/Documents/weekly_plan.md<CR>]], { desc = 'Open Weekly Plan' })
keymap('n', '<leader>gn', function() dotfiles.open_markdown_file_from_git_branch() end, { desc = 'Open notes for current Git branch' })

-- Other mappings
keymap('n', '-', [[<cmd>NvimTreeFindFileToggle<CR>]])
keymap('n', 'T', [[$p]])
keymap('n', '<C-h>', [[<cmd>tabprevious<CR>]])
keymap('n', '<C-l>', [[<cmd>tabnext<CR>]])
keymap('n', '<C-n>', [[<cmd>tabnew<CR>]])
keymap('n', '<S-h>', [[<C-w>h]])
keymap('n', '<S-j>', [[<C-w>j]])
keymap('n', '<S-k>', [[<C-w>k]])
keymap('n', '<S-l>', [[<C-w>l]])

keymap('n', '<C-c>', [[<cmd>Topen <bar> :TestNearest<CR>]])
keymap('n', '<C-f>', [[<cmd>Topen <bar> :TestFile<CR>]])
keymap('n', '<C-x>', function() dotfiles.run_last_command() end)
keymap('i', 'jk', '<Esc>')
keymap('i', 'jj', '<Esc>')
keymap('t', 'jj', [[<C-\><C-n>]])
keymap('t', '<Esc>', [[<C-\><C-n>]])

-------------------------------------------------------------------------------
-- Autocmds
-------------------------------------------------------------------------------

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.tsx,*.ts,*.jsx,*.js,*.vue',
  callback = function()
    vim.cmd('EslintFixAll')
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.json,*.rb',
  callback = function()
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
vim.cmd([[autocmd BufEnter COMMIT_EDITMSG lua require('options').insert_ticket_token()]])

-- Auto-reload files changed outside of Neovim
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  callback = function()
    if vim.fn.getcmdwintype() == '' then
      vim.cmd('checktime')
    end
  end,
})

-- Poll for changes every 2 seconds
local autoread_timer = vim.loop.new_timer()
autoread_timer:start(2000, 2000, vim.schedule_wrap(function()
  if vim.fn.getcmdwintype() == '' then
    vim.cmd('checktime')
  end
end))

-------------------------------------------------------------------------------
-- Aliases
-------------------------------------------------------------------------------

vim.cmd([[command! -bang WQ wq<bang>]])
vim.cmd([[command! -bang Wq wq<bang>]])
vim.cmd([[command! -bang Q q<bang>]])
vim.cmd([[command! -bang Qa qa<bang>]])
vim.cmd([[command! -bang Tabo tabo<bang>]])
vim.cmd([[command! Gblame Git blame]])
vim.cmd([[command! Gbrowse GBrowse]])
vim.cmd([[command! Gpush Git push]])

-------------------------------------------------------------------------------
-- Export dotfiles functions for autocmds
-------------------------------------------------------------------------------

return dotfiles
