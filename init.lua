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
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'
end)

vim.g.neoterm_autoscroll = 1
vim.g.neoterm_default_mod = 'botright'
vim.g.neoterm_size = 15
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
]])

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
    virtual_text = false,
    signs = true,
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

-- Fold RSpec specs using Treesitter
vim.api.nvim_create_autocmd('BufEnter', {
    desc = 'Fold RSpec specs',
    pattern = '*_spec.rb',
    callback = function(args)
        vim.wo.foldlevel = 3
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
        vim.wo.foldcolumn = 'auto:9'
        vim.cmd(':normal! zx') -- Works around bug in Telescope: https://github.com/nvim-telescope/telescope.nvim/issues/699
    end,
})

-- Typo forgiveness
vim.cmd([[command! -bang WQ wq<bang>]])
vim.cmd([[command! -bang Wq wq<bang>]])
vim.cmd([[command! -bang W w<bang>]])
vim.cmd([[command! -bang Q q<bang>]])
vim.cmd([[command! -bang Qa qa<bang>]])
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


-- My new scheme based on monokai
-- TODO: Add TS* groups
-- TODO: Move to new color scheme repo?

vim.cmd([[
  set background=dark
  highlight clear

  if exists('syntax_on')
    syntax reset
  endif

  set t_Co=256
  let g:colors_name = 'monokai'
]])

local black                = '#000000'
local bright_green         = '#a6e22e'
local bright_pink          = '#f92672'
local comment_grey         = '#75715e'
local fold_color           = '#272822'
local light_grey           = '#3c3d37'
local light_text           = '#f8f8f0'
local lighter_grey         = '#90908a'
local purple               = '#ae81ff'
local sky_blue             = '#66d9ef'
local status_back          = '#64645e'
local string_yellow        = '#e6db74'
local alternate_foreground = '#f8f8f2'
local diff_add             = '#46830c'

local unnamed7 = '#204a87'
local unnamed9 = '#272822'
local unnamed10 = '#243955'
local unnamed14 = '#49483e'
local unnamed15 = '#f8f8f0'
local unnamed16 = '#272822'
local unnamed17 = '#fd971f'
local unnamed18 = '#8b0807'
local unnamed19 = '#f92672'
local unnamed20 = '#c4be89'

-- My Additional Treesitter Styles
vim.api.nvim_set_hl(0, 'TSType', { fg = sky_blue })

-- Base Styles
vim.api.nvim_set_hl(0, 'Boolean', { fg = purple })
vim.api.nvim_set_hl(0, 'Character', { fg = purple })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = light_grey })
vim.api.nvim_set_hl(0, 'Comment', { fg = comment_grey })
vim.api.nvim_set_hl(0, 'Conceal', { fg = unnamed15 })
vim.api.nvim_set_hl(0, 'Conditional', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'Cursor', { fg = unnamed16, bg = unnamed15 })
vim.api.nvim_set_hl(0, 'CursorColumn', { bg = light_grey })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = light_grey })
vim.api.nvim_set_hl(0, 'Define', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'DiffAdd', { fg = alternate_foreground, bg = diff_add, bold = true })
vim.api.nvim_set_hl(0, 'DiffChange', { fg = alternate_foreground, bg = unnamed10 })
vim.api.nvim_set_hl(0, 'DiffDelete', { fg = unnamed18 })
vim.api.nvim_set_hl(0, 'DiffText', { fg = alternate_foreground, bg = unnamed7, bold = true })
vim.api.nvim_set_hl(0, 'Directory', { fg = purple })
vim.api.nvim_set_hl(0, 'ErrorMsg', { bg = bright_pink, fg = light_text })
vim.api.nvim_set_hl(0, 'Float', { fg = purple })
vim.api.nvim_set_hl(0, 'Folded', { fg = comment_grey, bg = fold_color })
vim.api.nvim_set_hl(0, 'Function', { fg = bright_green })
vim.api.nvim_set_hl(0, 'Identifier', { fg = sky_blue, italic = true })
vim.api.nvim_set_hl(0, 'IncSearch', { fg = unnamed20, bg = black, reverse = true })
vim.api.nvim_set_hl(0, 'Label', { fg = string_yellow })
vim.api.nvim_set_hl(0, 'LineNr', { bg = light_grey, fg = lighter_grey })
vim.api.nvim_set_hl(0, 'MatchParen', { fg = bright_pink, underline = true })
vim.api.nvim_set_hl(0, 'NonText', { fg = comment_grey })
vim.api.nvim_set_hl(0, 'Normal', { fg = alternate_foreground, bg = unnamed9 })
vim.api.nvim_set_hl(0, 'Number', { fg = purple })
vim.api.nvim_set_hl(0, 'Operator', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = unnamed14 })
vim.api.nvim_set_hl(0, 'PreProc', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'Search', { fg = alternate_foreground, bg = unnamed7 })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = light_grey })
vim.api.nvim_set_hl(0, 'Special', { fg = alternate_foreground })
vim.api.nvim_set_hl(0, 'SpecialChar', { fg = purple })
vim.api.nvim_set_hl(0, 'SpecialComment', { fg = comment_grey })
vim.api.nvim_set_hl(0, 'SpecialKey', { fg = comment_grey })
vim.api.nvim_set_hl(0, 'Statement', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'StatusLine', { fg = alternate_foreground, bg = status_back, bold = true })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = alternate_foreground, bg = status_back })
vim.api.nvim_set_hl(0, 'StorageClass', { fg = sky_blue, italic = true })
vim.api.nvim_set_hl(0, 'String', { fg = string_yellow })
vim.api.nvim_set_hl(0, 'TSKeyword', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'Tag', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'Title', { fg = alternate_foreground, bold = true })
vim.api.nvim_set_hl(0, 'Todo', { fg = comment_grey, bold = true })
vim.api.nvim_set_hl(0, 'Type', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'Underlined', { underline = true })
vim.api.nvim_set_hl(0, 'VertSplit', { fg = status_back, bg = status_back })
vim.api.nvim_set_hl(0, 'Visual', { bg = unnamed14 })
vim.api.nvim_set_hl(0, 'WarningMsg', { bg = bright_pink, fg = light_text })
vim.api.nvim_set_hl(0, 'cssClassName', { fg = bright_green })
vim.api.nvim_set_hl(0, 'cssColor', { fg = purple })
vim.api.nvim_set_hl(0, 'cssCommonAttr', { fg = sky_blue })
vim.api.nvim_set_hl(0, 'cssFunctionName', { fg = sky_blue })
vim.api.nvim_set_hl(0, 'cssPseudoClassId', { fg = bright_green })
vim.api.nvim_set_hl(0, 'cssURL', { fg = unnamed17, italic = true })
vim.api.nvim_set_hl(0, 'cssValueLength', { fg = purple })
vim.api.nvim_set_hl(0, 'diffAdded', { fg = bright_green })
vim.api.nvim_set_hl(0, 'diffFile', { fg = sky_blue })
vim.api.nvim_set_hl(0, 'diffIndexLine', { fg = comment_grey })
vim.api.nvim_set_hl(0, 'diffLine', { fg = sky_blue })
vim.api.nvim_set_hl(0, 'diffRemoved', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'diffSubname', { fg = comment_grey })
vim.api.nvim_set_hl(0, 'erubyComment', { fg = comment_grey })
vim.api.nvim_set_hl(0, 'erubyRailsMethod', { fg = sky_blue })
vim.api.nvim_set_hl(0, 'helpCommand', { fg = bright_green })
vim.api.nvim_set_hl(0, 'htmlEndTag', { fg = bright_green })
vim.api.nvim_set_hl(0, 'htmlSpecialChar', { fg = purple })
vim.api.nvim_set_hl(0, 'htmlTag', { fg = bright_green })
vim.api.nvim_set_hl(0, 'javaScriptFunction', { fg = sky_blue, italic = true })
vim.api.nvim_set_hl(0, 'javaScriptRailsFunction', { fg = sky_blue })
vim.api.nvim_set_hl(0, 'markdownCode', { fg = comment_grey })
vim.api.nvim_set_hl(0, 'markdownHeadingDelimiter', { fg = unnamed19 })
vim.api.nvim_set_hl(0, 'markdownLink', { fg = sky_blue, underline = true })
vim.api.nvim_set_hl(0, 'markdownLinkDelimiter', { fg = sky_blue })
vim.api.nvim_set_hl(0, 'markdownLinkText', { fg = alternate_foreground })
vim.api.nvim_set_hl(0, 'markdownLinkTextDelimiter', { fg = sky_blue })
vim.api.nvim_set_hl(0, 'markdownUrl', { fg = sky_blue, underline = true })
vim.api.nvim_set_hl(0, 'rubyBlockParameter', { fg = unnamed17, italic = true })
vim.api.nvim_set_hl(0, 'rubyClass', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'rubyConstant', { fg = sky_blue, italic = true })
vim.api.nvim_set_hl(0, 'rubyControl', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'rubyEscape', { fg = purple })
vim.api.nvim_set_hl(0, 'rubyException', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'rubyFunction', { fg = bright_green })
vim.api.nvim_set_hl(0, 'rubyInclude', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'rubyOperator', { fg = bright_pink })
vim.api.nvim_set_hl(0, 'rubyRailsARAssociationMethod', { fg = sky_blue })
vim.api.nvim_set_hl(0, 'rubyRailsARMethod', { fg = sky_blue })
vim.api.nvim_set_hl(0, 'rubyRailsMethod', { fg = sky_blue })
vim.api.nvim_set_hl(0, 'rubyRailsRenderMethod', { fg = sky_blue })
vim.api.nvim_set_hl(0, 'rubyRailsUserClass', { fg = sky_blue, italic = true })
vim.api.nvim_set_hl(0, 'rubyRegexp', { fg = string_yellow })
vim.api.nvim_set_hl(0, 'rubyRegexpDelimiter', { fg = string_yellow })
vim.api.nvim_set_hl(0, 'rubyStringDelimiter', { fg = string_yellow })
vim.api.nvim_set_hl(0, 'rubySymbol', { fg = purple })
vim.api.nvim_set_hl(0, 'shDerefSimple', { fg = sky_blue, italic = true })
vim.api.nvim_set_hl(0, 'shQuote', { fg = string_yellow })
vim.api.nvim_set_hl(0, 'yamlDocumentHeader', { fg = string_yellow })
vim.api.nvim_set_hl(0, 'yamlKey', { fg = bright_pink })
