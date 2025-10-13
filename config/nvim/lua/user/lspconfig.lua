local M = {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    {
      'folke/neodev.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
  },
}

function M.config()
  vim.lsp.enable('jsonls')
  vim.lsp.enable('ruby_lsp')

  vim.diagnostic.config({
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = true,
  })

  vim.fn.sign_define('DiagnosticSignError', { texthl = 'DiagnosticSignError', text = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignWarn', { texthl = 'DiagnosticSignWarn', text = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignInfo', { texthl = 'DiagnosticSignInfo', text = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DiagnosticSignHint', { texthl = 'DiagnosticSignHint', text = '', linehl = '', numhl = '' })

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

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  vim.lsp.config('jsonls', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  vim.lsp.config('ruby_lsp', {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
      formatter = 'rubocop',
      linters = { 'rubocop' },
    },
  })

  vim.lsp.config('eslint', {
  })
end

return M
