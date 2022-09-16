-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer = require('packer')
local use = packer.use

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'init.lua',
  callback = function(args)
    packer.compile()
  end,
})

require('packer').startup(function()
  use 'L3MON4D3/LuaSnip'
  use 'RRethy/nvim-treesitter-endwise'
  use 'ahmedkhalf/project.nvim'
  use 'diepm/vim-rest-console'
  use 'folke/trouble.nvim'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'kassio/neoterm'
  use 'kstevens715/monokai.nvim'
  use 'max397574/better-escape.nvim'
  use 'neovim/nvim-lspconfig'
  use 'norcalli/nvim-colorizer.lua'
  use 'ntpeters/vim-better-whitespace'
  use 'numToStr/Comment.nvim'
  use 'nvim-treesitter/playground'
  use 'rafamadriz/friendly-snippets'
  use 'saadparwaiz1/cmp_luasnip'
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
  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }
end)

vim.g.neoterm_autoscroll = 1
vim.g.neoterm_default_mod = 'botright'
vim.g.neoterm_size = 33
vim.g.ruby_indent_assignment_style = 'variable'
vim.g.strip_only_modified_lines=1
vim.g.strip_whitespace_confirm=0
vim.g.strip_whitespace_on_save=1
vim.g['test#ruby#rspec#options'] = { all = '--format progress' }
vim.g['test#strategy'] = 'neoterm'
vim.o.autoread = true
vim.o.background = 'light'
vim.o.clipboard = 'unnamed'
vim.o.completeopt = 'menu,menuone,noselect'
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

vim.fn.sign_define('DiagnosticSignError', { texthl = 'DiagnosticSignError', text = '', linehl = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarn', { texthl = 'DiagnosticSignWarn', text = '', linehl = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignInfo', { texthl = 'DiagnosticSignInfo', text = '', linehl = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', text = '', linehl = '', numhl = '' })

vim.keymap.set('n', '<leader>c', [[<cmd>Git<CR>]])
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
vim.keymap.set('n', '<leader>h', [[<cmd>Telescope git_bcommits<CR>]])
vim.keymap.set('n', '<leader>p', [[<cmd>Telescope projects<CR>]])
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

vim.cmd([[
  set background=dark
  colorscheme monokai
]])

require('colorizer').setup()
require('better_escape').setup()
require('Comment').setup()
require('project_nvim').setup()
require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')
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
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

require('lualine').setup()

require('trouble').setup {
  icons = true,
  signs = {
    error = '',
    warning = '',
    hint = '',
    information = '',
    other = '﫠'
  },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'bash', 'css', 'dockerfile', 'html', 'javascript', 'json', 'lua', 'python', 'ruby', 'scss', 'vim', 'vue', 'yaml' },
  endwise = { enable = true },
  highlight = { enable = true },
  indent = { enable = false }, -- TODO When enabled, new lines in Ruby are indenting an extra 2 spaces
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = true,
  }
)

-- Setup nvim-cmp.
require('luasnip').filetype_extend('ruby', {'rails'})
require('luasnip.loaders.from_vscode').lazy_load()

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
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path' },
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

-- Set file type mappings
-- :help lua-filetype
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

vim.filetype.add({
  extension = {
    es6 = 'javascript',
  },
  filename = {
    ['Gemfile'] = 'ruby',
  }
})

-- Typo forgiveness
vim.cmd([[command! -bang WQ wq<bang>]])
vim.cmd([[command! -bang Wq wq<bang>]])
vim.cmd([[command! -bang W w<bang>]])
vim.cmd([[command! -bang Q q<bang>]])
vim.cmd([[command! -bang Qa qa<bang>]])
vim.cmd([[command! -bang Tabo tabo<bang>]])
vim.cmd([[command! Gblame Git blame]])
vim.cmd([[command! Gbrowse GBrowse]])
vim.cmd([[command! Gpush Git push]])

vim.cmd([[
  let g:vrc_allow_get_request_body = 1
  let g:vrc_output_buffer_name = '__VRC_OUTPUT.json'
  let g:vrc_response_default_content_type = 'application/json'
  let g:vrc_show_command = 0
  let g:vrc_curl_opts = {
    \ '-sS': ''
  \}
]])
