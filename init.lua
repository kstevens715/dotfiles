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
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'wbthomason/packer.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
end)

require('nightfox').load('duskfox')

require('lualine').setup {
  options = {
    theme = 'nightfox'
  },
}

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<C-h>', [[<cmd>tabprevious <CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', [[<cmd>tabnext <CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', [[<cmd>tabnew <CR>]], { noremap = true, silent = true })
