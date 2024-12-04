local keymap = vim.keymap.set
local dotfiles = require('user.dotfiles')

-- Leader Mappings
keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { desc = 'View Buffers' })
keymap('n', '<leader>c', [[<cmd>Git<CR>]], { desc = 'Git Commit' })
keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { desc = 'Search Project' })
keymap('n', '<leader>x', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { desc = 'Search Project' })
keymap('n', '<leader>h', [[<cmd>Telescope git_bcommits<CR>]], { desc = 'Git History' })
keymap('n', '<leader>l', [[<cmd>! flog %<CR>]], { desc = 'Flog (ABC) Score' })
keymap('n', '<leader>r', [[<cmd>lua require('telescope.builtin').registers()<CR>]], { desc = 'Registers' })
keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { desc = 'Find Files' })
keymap('n', '<leader>y', [[<cmd>YAMLTelescope<CR>]], { desc = 'View YAML values in project' })
keymap('v', '<leader>s', [[:'<,'>sort<CR>]], { desc = 'Sort Lines' })

-- Double-key mappings. IMPORTANT: First key should not match any of my primary leader mappings above or it'll slow them down!
keymap('n', '<leader>ve', [[<cmd>e ~/dotfiles/config/nvim/init.lua<CR>]], { desc = 'Edit Vim Config' })
keymap('n', '<leader>vr', [[<cmd>source ~/dotfiles/config/nvim/init.lua<CR>]], { desc = 'Reload Vim Config' })
keymap('n', '<leader>wm', [[<cmd>e ~/Documents/working_memory.md<CR>]], { desc = 'Open Working Memory' })
keymap('n', '<leader>wp', [[<cmd>e ~/Documents/weekly_plan.md<CR>]], { desc = 'Open Weekly Plan' })
keymap('n', '<leader>gn', [[<cmd>lua require('user.dotfiles').open_markdown_file_from_git_branch()<CR>]], { desc = 'Open notes for current Git branch' })

-- Other Mappings
keymap('n', '-', [[<cmd>NvimTreeFindFileToggle<CR>]])
keymap('n', 'T', [[$p]]) -- Paste at end of line by pressing `T`
keymap('n', '<C-h>', [[<cmd>tabprevious <CR>]])
keymap('n', '<C-l>', [[<cmd>tabnext <CR>]])
keymap('n', '<C-n>', [[<cmd>tabnew <CR>]])
keymap('n', '<S-h>', [[<C-w>h]])
keymap('n', '<S-j>', [[<C-w>j]])
keymap('n', '<S-k>', [[<C-w>k]])
keymap('n', '<S-l>', [[<C-w>l]])

keymap('n', '<C-c>', [[<cmd>Topen <bar> :TestNearest <CR>]])
keymap('n', '<C-f>', [[<cmd>Topen <bar> :TestFile  <CR>]])
keymap('n', '<C-x>', [[<cmd>lua require('user.dotfiles').run_last_command()<CR>]])
keymap('t', 'jj', [[<C-\><C-n>]])
keymap('t', '<Esc>', [[<C-\><C-n>]])
