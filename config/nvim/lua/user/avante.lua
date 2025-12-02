local M = {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    {
      'nvim-tree/nvim-web-devicons',
      lazy = true
    },
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
  },
}

function M.config()
  require('avante').setup({
    provider = 'claude',
    providers = {
      claude = {
        endpoint = 'https://api.anthropic.com',
        model = 'claude-sonnet-4-5-20250929',
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
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
      toggle = {
        default = '<leader>at',
        debug = '<leader>ad',
        hint = '<leader>ah',
      },
    },
    windows = {
      wrap = true,
      width = 30,
      sidebar_header = {
        align = 'center',
        rounded = true,
      },
    },
    highlights = {
      diff = {
        current = 'DiffText',
        incoming = 'DiffAdd',
      },
    },
  })
end

return M
