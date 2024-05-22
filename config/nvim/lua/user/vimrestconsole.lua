local M = {
  'diepm/vim-rest-console',
}

function M.config()
  vim.g.vrc_output_buffer_name = '__VRC_OUTPUT.json'
  vim.g.vrc_response_default_content_type = 'application/json'
  vim.g.vrc_show_command = 1
  vim.g.vrc_auto_format_response_enabled = 1
  vim.g.vrc_curl_opts = {
    ['--silent'] = '',
    ['--include'] = ''
  }
  vim.g.vrc_auto_format_response_patterns = {
    json = 'jq'
  }
  -- vim.g.vrc_allow_get_request_body = 1 -- Cannot be used in conjunction with vrc_split_request_body
end

return M
