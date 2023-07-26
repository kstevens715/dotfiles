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
  use 'diepm/vim-rest-console'
  use 'folke/trouble.nvim'
  use 'folke/which-key.nvim'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'kassio/neoterm'
  use 'kburdett/vim-nuuid'
  use 'kyazdani42/nvim-web-devicons'
  use 'max397574/better-escape.nvim'
  use 'neovim/nvim-lspconfig'
  use 'ntpeters/vim-better-whitespace'
  use 'numToStr/Comment.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-treesitter/playground'
  use 'rafamadriz/friendly-snippets'
  use 'saadparwaiz1/cmp_luasnip'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rails'
  use 'tpope/vim-repeat'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-surround'
  use 'vim-test/vim-test'
  use 'wbthomason/packer.nvim'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'mcchrish/zenbones.nvim', requires = { "rktjmp/lush.nvim" } }
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)

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

function open_markdown_file_from_git_branch()
  local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD')
  branch = string.gsub(branch, '\n', '')
  local filename = '/Users/kstevens/Documents/Tickets/' .. vim.fn.substitute(branch, '/', '_', 'g') .. '.md'
  vim.api.nvim_command('edit ' .. vim.fn.fnameescape(filename))
  vim.bo.filetype = 'markdown'
end


vim.g.better_whitespace_enabled = 1
vim.g.neoterm_autoscroll = 1
vim.g.neoterm_default_mod = 'botright'
vim.g.neoterm_size = 25
vim.g.ruby_indent_assignment_style = 'variable'
vim.g.strip_whitespace_confirm = 0
vim.g.strip_whitespace_on_save = 1
vim.g.strip_only_modified_lines = 1
vim.g['test#ruby#rspec#options'] = { all = '--format progress' }
vim.g['test#strategy'] = 'neoterm'
vim.g.vrc_output_buffer_name = '__VRC_OUTPUT.json'
vim.g.vrc_response_default_content_type = 'application/json'
vim.g.vrc_show_command = 1
-- vim.g.vrc_allow_get_request_body = 1 -- Cannot be used in conjunction with vrc_split_request_body
vim.o.autoread = true
vim.o.background = 'light'
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

vim.fn.sign_define('DiagnosticSignError', { texthl = 'DiagnosticSignError', text = '', linehl = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarn', { texthl = 'DiagnosticSignWarn', text = '', linehl = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignInfo', { texthl = 'DiagnosticSignInfo', text = '', linehl = '', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', text = '', linehl = '', numhl = '' })

-- Leader Mappings
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { desc = 'View Buffers' })
vim.keymap.set('n', '<leader>c', [[<cmd>Git<CR>]], { desc = 'Git Commit' })
vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { desc = 'Search Project' })
vim.keymap.set('n', '<leader>h', [[<cmd>Telescope git_bcommits<CR>]], { desc = 'Git History' })
vim.keymap.set('n', '<leader>l', [[<cmd>! flog %<CR>]], { desc = 'Flog (ABC) Score' })
vim.keymap.set('n', '<leader>r', [[<cmd>TroubleToggle<CR>]], { desc = 'View Warnings/Errors' })
vim.keymap.set('n', '<leader>t', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { desc = 'Find Files' })
vim.keymap.set('v', '<leader>s', [[:'<,'>sort<CR>]], { desc = 'Sort Lines' })

-- Double-key mappings. IMPORTANT: First key should not match any of my primary leader mappings above or it'll slow them down!
vim.keymap.set('n', '<leader>n', [[<cmd>e ~/Documents/ticket_notes.md<CR>]], { desc = 'Open Ticket Notes' })
vim.keymap.set('n', '<leader>ve', [[<cmd>e ~/dotfiles/init.lua<CR>]], { desc = 'Edit Vim Config' })
vim.keymap.set('n', '<leader>vr', [[<cmd>source ~/dotfiles/init.lua<CR>]], { desc = 'Reload Vim Config' })
vim.keymap.set('n', '<leader>wm', [[<cmd>e ~/Documents/working_memory.md<CR>]], { desc = 'Open Working Memory' })
vim.keymap.set('n', '<leader>wp', [[<cmd>e ~/Documents/weekly_plan.md<CR>]], { desc = 'Open Weekly Plan' })
vim.keymap.set('n', '<leader>gn', [[<cmd>lua open_markdown_file_from_git_branch()<CR>]], { desc = 'Open notes for current Git branch' })

-- Other Mappings
vim.keymap.set('n', '-', [[<cmd>NvimTreeFindFileToggle<CR>]])
vim.keymap.set('n', 'T', [[$p]]) -- Paste at end of line by pressing `T`
vim.keymap.set('n', '<C-h>', [[<cmd>tabprevious <CR>]])
vim.keymap.set('n', '<C-l>', [[<cmd>tabnext <CR>]])
vim.keymap.set('n', '<C-n>', [[<cmd>tabnew <CR>]])
vim.keymap.set('n', '<S-h>', [[<C-w>h]])
vim.keymap.set('n', '<S-j>', [[<C-w>j]])
vim.keymap.set('n', '<S-k>', [[<C-w>k]])
vim.keymap.set('n', '<S-l>', [[<C-w>l]])

vim.keymap.set('n', '<C-c>', [[<cmd>Topen <bar> :TestNearest <CR>]])
vim.keymap.set('n', '<C-f>', [[<cmd>Topen <bar> :TestFile  <CR>]])
vim.keymap.set('n', '<C-x>', [[<cmd>Topen <bar> :TestLast <CR>]])
vim.keymap.set('t', 'jj', [[<C-\><C-n>]])
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

vim.cmd([[
  " Important!!
  if has('termguicolors')
    set termguicolors
  endif
  set background=dark
  colorscheme zenbones
]])

require('better_escape').setup()
require('Comment').setup()
require('telescope').load_extension('fzf')
require('telescope.builtin')
require('which-key').setup()
require "telescope".setup {
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  }
}


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
  buf_set_keymap('n', 'gF', '<Cmd>lua vim.lsp.buf.format()<CR>', opts)
  buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

require('lualine').setup {
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1,           -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
  },
  options = { theme = 'zenbones' }
}

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

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'bash', 'comment', 'css', 'dockerfile', 'html', 'javascript', 'json', 'lua', 'python', 'ruby', 'scss', 'scheme', 'vim', 'vue', 'yaml' },
  endwise = { enable = true },
  highlight = { enable = true },
  indent = { enable = false },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_hl_groups = 'i',
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = true,
  }
)

require("nvim-tree").setup({
  update_focused_file = {
    enable = true
  }
})

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
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require('lspconfig').jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

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

require('lspconfig').eslint.setup {
}

-- Autoformat files on save

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.tsx,*.ts,*.jsx,*.js,*.vue',
  callback = function(args)
    vim.cmd('EslintFixAll')
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.rb',
  callback = function(args)
    if not string.match(args.file, "spec%.rb$") and not string.match(args.file, "routes.rb$") then
      vim.lsp.buf.format()
    end
  end,
})

-- Set file type mappings
-- :help lua-filetype
vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0
vim.cmd 'autocmd BufRead,BufNewFile *.scm set filetype=scheme'

vim.filetype.add({
  extension = {
    es6 = 'javascript',
    scm = 'scheme',
  },
  filename = {
    ['Gemfile'] = 'ruby',
    ['.env.test'] = 'sh',
    ['.env.example'] = 'sh',
  }
})

vim.cmd [[autocmd BufEnter COMMIT_EDITMSG lua insert_ticket_token()]]

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
