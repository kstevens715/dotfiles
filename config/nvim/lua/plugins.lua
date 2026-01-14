-- All plugins in one place

return {
  -------------------------------------------------------------------------------
  -- Colorscheme & Appearance
  -------------------------------------------------------------------------------

  {
    'EdenEast/nightfox.nvim',
    config = function()
      vim.cmd.colorscheme 'nightfox'
    end,
  },

  {
    'cormacrelf/dark-notify',
    config = function()
      require('dark_notify').run({
        schemes = {
          dark = 'nightfox',
          light = 'dayfox',
        }
      })
    end,
  },

  {
    'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
  },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
          }
        end
      end

      require('lualine').setup {
        sections = {
          lualine_b = { { 'diff', source = diff_source } },
          lualine_c = { { 'filename', file_status = true, path = 1 } },
          lualine_x = { 'rest' }
        }
      }
    end,
  },

  { 'folke/which-key.nvim', config = function() require('which-key').setup() end },

  -------------------------------------------------------------------------------
  -- Git
  -------------------------------------------------------------------------------

  { 'tpope/vim-fugitive', lazy = false },
  { 'tpope/vim-rhubarb', lazy = false },
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = function() require('gitsigns').setup() end },

  -------------------------------------------------------------------------------
  -- Fuzzy Finding & Navigation
  -------------------------------------------------------------------------------

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', lazy = true },
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    config = function()
      require('telescope').load_extension('fzf')
      require('telescope').setup {
        pickers = { colorscheme = { enable_preview = true } }
      }
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    event = 'VeryLazy',
    config = function()
      require('nvim-tree').setup({ update_focused_file = { enable = true } })
    end,
  },

  -------------------------------------------------------------------------------
  -- LSP & Completion
  -------------------------------------------------------------------------------

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'folke/neodev.nvim', 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      vim.lsp.enable('jsonls')
      vim.lsp.enable('ruby_lsp')

      vim.diagnostic.config({
        signs = true,
        underline = true,
        update_in_insert = false,
        virtual_text = true,
      })

      vim.fn.sign_define('DiagnosticSignError', { texthl = 'DiagnosticSignError', text = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DiagnosticSignWarn', { texthl = 'DiagnosticSignWarn', text = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DiagnosticSignInfo', { texthl = 'DiagnosticSignInfo', text = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', text = '', linehl = '', numhl = '' })

      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local opts = { noremap = true, silent = true }
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'gF', '<Cmd>lua vim.lsp.buf.format()<CR>', opts)
        buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', 'rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.lsp.config('jsonls', { on_attach = on_attach, capabilities = capabilities })
      vim.lsp.config('ruby_lsp', {
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = { formatter = 'rubocop', linters = { 'rubocop' } },
      })
      vim.lsp.config('eslint', {})
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path' },
    config = function()
      local cmp = require('cmp')
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
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'buffer' },
        })
      })
    end,
  },

  -------------------------------------------------------------------------------
  -- TreeSitter
  -------------------------------------------------------------------------------

  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = { 'RRethy/nvim-treesitter-endwise', 'nvim-treesitter/playground' },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'comment', 'css', 'dockerfile', 'html', 'http', 'javascript', 'json', 'lua', 'markdown', 'python', 'ruby', 'scss', 'scheme', 'vim', 'vimdoc', 'vue', 'xml', 'yaml' },
        endwise = { enable = true },
        highlight = { enable = true },
        indent = { enable = false },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,
          persist_queries = false,
          keybindings = { toggle_hl_groups = 'i' },
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
    end,
  },

  { 'nvim-treesitter/nvim-treesitter-context', config = function() require('treesitter-context').setup() end },

  -------------------------------------------------------------------------------
  -- Editing
  -------------------------------------------------------------------------------

  { 'tpope/vim-surround' },
  { 'tpope/vim-repeat' },
  { 'numToStr/Comment.nvim', lazy = false, config = function() require('Comment').setup() end },
  { 'ntpeters/vim-better-whitespace' },
  {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup {
        mappings = {
          i = { j = { k = "<Esc>", j = "<Esc>" } },
          c = { j = { k = "<Esc>", j = "<Esc>" } },
          t = { j = { k = "<C-\\><C-n>" } },
          v = { j = { k = false } },
          s = { j = { k = "<Esc>" } },
        }
      }
    end,
  },

  -------------------------------------------------------------------------------
  -- Testing & Terminal
  -------------------------------------------------------------------------------

  { 'kassio/neoterm' },
  { 'vim-test/vim-test' },

  -------------------------------------------------------------------------------
  -- Ruby / Rails
  -------------------------------------------------------------------------------

  { 'tpope/vim-rails' },

  -------------------------------------------------------------------------------
  -- AI
  -------------------------------------------------------------------------------

  { 'github/copilot.vim' },

  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    build = 'make',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      { 'nvim-tree/nvim-web-devicons', lazy = true },
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
          },
        },
      },
    },
    config = function()
      require('avante').setup({
        provider = 'claude',
        providers = {
          claude = {
            endpoint = 'https://api.anthropic.com',
            model = 'claude-sonnet-4-5-20250929',
            extra_request_body = { temperature = 0, max_tokens = 4096 },
          },
        },
        behaviour = {
          auto_suggestions = false,
          auto_set_highlight_group = true,
          auto_set_keymaps = true,
          auto_apply_diff_after_generation = false,
          support_paste_from_clipboard = false,
        },
        mappings = {
          ask = '<leader>aa',
          edit = '<leader>ae',
          refresh = '<leader>ar',
          toggle = { default = '<leader>at', debug = '<leader>ad', hint = '<leader>ah' },
        },
        windows = {
          wrap = true,
          width = 30,
          sidebar_header = { align = 'center', rounded = true },
        },
        highlights = {
          diff = { current = 'DiffText', incoming = 'DiffAdd' },
        },
      })
    end,
  },

  -------------------------------------------------------------------------------
  -- Misc
  -------------------------------------------------------------------------------

  { 'kburdett/vim-nuuid' },
  { 'cuducos/yaml.nvim', config = function() require('yaml_nvim') end },

  {
    'rest-nvim/rest.nvim',
    config = function()
      vim.keymap.set('n', '<C-j>', '<cmd>Rest run<CR>', { desc = 'Run REST command' })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'json',
        callback = function(ev)
          vim.bo.formatexpr = ''
          vim.bo.formatprg = 'jq'
          vim.bo[ev.buf].filetype = 'json'
        end
      })
    end,
  },
}
