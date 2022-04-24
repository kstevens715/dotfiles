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
  use 'RRethy/nvim-treesitter-endwise'
  use 'diepm/vim-rest-console'
  use 'folke/trouble.nvim'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/nvim-cmp'
  use 'kassio/neoterm'
  use 'max397574/better-escape.nvim'
  use 'neovim/nvim-lspconfig'
  use 'ntpeters/vim-better-whitespace'
  use 'numToStr/Comment.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rails'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-vinegar'
  use 'vim-test/vim-test'
  use 'wbthomason/packer.nvim'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'mcchrish/zenbones.nvim', requires = { 'rktjmp/lush.nvim' } }
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

require('better_escape').setup()
require('Comment').setup()
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

require('lualine').setup {
  options = {
    theme = "zenbones"
  }
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
  ensure_installed = { "bash", "css", "dockerfile", "html", "javascript", "json", "lua", "python", "ruby", "scss", "vim", "vue", "yaml" },

  endwise = {
    enable = true,
  },

  highlight = {
    enable = true,
  },

  indent = {
    enable = false -- TODO When enabled, new lines in Ruby are indenting an extra 2 spaces
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

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig').solargraph.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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


vim.cmd [[
  set background=light
  colorscheme zenbones
  set completeopt=menu,menuone,noselect

  autocmd BufEnter *.es6 :setlocal filetype=javascript

  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Todo", timeout=500})
  augroup END

  " TODO: Stuff that still needs conversion from init.vim
  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
  let g:ruby_indent_assignment_style = 'variable'
  let g:neoterm_autoscroll = 1
  let g:neoterm_default_mod = 'botright'
  let g:neoterm_size = 15
  let test#strategy = "neoterm"
  let test#ruby#rspec#options = {
    \ 'all':   '--format progress',
  \}

  let g:strip_whitespace_on_save=1
  let g:strip_whitespace_confirm=0
  let g:strip_only_modified_lines=1
]]

vim.keymap.set('n', '<leader>c', [[<cmd>Git<CR>]])
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
vim.keymap.set('n', '<leader>t', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
vim.keymap.set('n', '<leader>ve', [[<cmd>e ~/dotfiles/init.lua<CR>]])
vim.keymap.set('n', '<leader>vr', [[<cmd>source ~/dotfiles/init.lua<CR>]])
vim.keymap.set('n', '<leader>wm', [[<cmd>e ~/Desktop/working_memory.md<CR>]])
vim.keymap.set('n', '<leader>r', [[<cmd>TroubleToggle<CR>]])
vim.keymap.set('n', '<C-h>', [[<cmd>tabprevious <CR>]])
vim.keymap.set('n', '<C-l>', [[<cmd>tabnext <CR>]])
vim.keymap.set('n', '<C-n>', [[<cmd>tabnew <CR>]])
vim.keymap.set('n', '<C-c>', [[<cmd>Topen <bar> :TestNearest <CR>]])
vim.keymap.set('n', '<C-f>', [[<cmd>Topen <bar> :TestFile  <CR>]])
vim.keymap.set('n', '<C-x>', [[<cmd>Topen <bar> :TestLast <CR>]])
vim.keymap.set('t', 'jj', [[<C-\><C-n>]])
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
