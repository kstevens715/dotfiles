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
  use 'diepm/vim-rest-console'
  use 'folke/trouble.nvim'
  use 'kassio/neoterm'
  use 'max397574/better-escape.nvim'
  use 'neovim/nvim-lspconfig'
  use 'numToStr/Comment.nvim'
  use 'tpope/vim-endwise'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rails'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-vinegar'
  use 'vim-test/vim-test'
  use 'wbthomason/packer.nvim'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)

vim.o.autoread = true
vim.o.clipboard = 'unnamed'
vim.o.cursorline = true
vim.o.expandtab = true
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

-- TODO: Stuff that still needs conversion from init.vim
-- map <leader>r :TroubleToggle <CR>
-- sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
-- sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
-- sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
-- sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
-- let g:ruby_indent_assignment_style = 'variable'
-- let g:neoterm_autoscroll = 1
-- let g:neoterm_default_mod = 'botright'
-- let g:neoterm_size = 15
-- let test#strategy = "neoterm"
-- let test#ruby#rspec#options = {
--   \ 'all':   '--format progress',
-- \}

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

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

require('lspconfig').solargraph.setup {
  on_attach = on_attach,
  settings = {
    solargraph = {
      useBundler = true,
      diagnostics = true,
    }
  },
  flags = {
    debounce_text_changes = 150,
  }
}

require('lualine').setup {
  options = {
    theme = 'nightfox'
  },
}

require("trouble").setup {
  icons = true,
  signs = {
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "﫠"
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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- This will disable virtual text, like doing:
    -- let g:diagnostic_enable_virtual_text = 0
    virtual_text = false,

    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = false,
  }
)

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>t', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>ve', [[<cmd>e ~/dotfiles/init.lua<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>vr', [[<cmd>source ~/dotfiles/init.lua<CR>]], opts)
vim.api.nvim_set_keymap('n', '<C-h>', [[<cmd>tabprevious <CR>]], opts)
vim.api.nvim_set_keymap('n', '<C-l>', [[<cmd>tabnext <CR>]], opts)
vim.api.nvim_set_keymap('n', '<C-n>', [[<cmd>tabnew <CR>]], opts)
vim.api.nvim_set_keymap('n', '<C-c>', [[<cmd>Topen <bar> :TestNearest <CR>]], opts)
vim.api.nvim_set_keymap('n', '<C-f>', [[<cmd>Topen <bar> :TestFile  <CR>]], opts)
vim.api.nvim_set_keymap('n', '<C-x>', [[<cmd>Topen <bar> :TestLast <CR>]], opts)
