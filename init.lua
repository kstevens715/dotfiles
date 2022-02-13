-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

local use = require('packer').use
require('packer').startup(function()
  use 'EdenEast/nightfox.nvim'
  use 'max397574/better-escape.nvim'
  use 'numToStr/Comment.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'wbthomason/packer.nvim'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)

require("better_escape").setup()
require('Comment').setup()
require('nightfox').load('duskfox')
require('telescope').load_extension 'fzf'
require('telescope.builtin')

require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

require('lualine').setup {
  options = {
    theme = 'nightfox'
  },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",

  highlight = {
    enable = true,
  },

  indent = {
    enable = true
  },
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>ve', [[<cmd>e ~/dotfiles/init.lua<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>vr', [[<cmd>source ~/dotfiles/init.lua<CR>]], opts)
vim.api.nvim_set_keymap('n', '<C-h>', [[<cmd>tabprevious <CR>]], opts)
vim.api.nvim_set_keymap('n', '<C-l>', [[<cmd>tabnext <CR>]], opts)
vim.api.nvim_set_keymap('n', '<C-n>', [[<cmd>tabnew <CR>]], opts)
