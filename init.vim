""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.local/share/nvim/plugged')

" Evaluating start
Plug 'TimUntersberger/neogit'
Plug 'sindrets/diffview.nvim'
" Evaluating end

Plug 'MattesGroeger/vim-bookmarks'
Plug 'airblade/vim-gitgutter'
Plug 'diepm/vim-rest-console'
Plug 'folke/trouble.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sainnhe/sonokai'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'vim-test/vim-test'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:sonokai_style = 'espresso'

highlight IncSearch guibg=green ctermbg=green term=underline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-RUBY CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ruby_indent_assignment_style = 'variable'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TELESCOPE CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>c <cmd>Telescope git_commits<cr>
nnoremap <leader>t <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>f <cmd>Telescope live_grep<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-TEST CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let test#ruby#rspec#options = {
  \ 'all':   '--format progress',
\}

nmap <silent> <C-c> :TestNearest <CR>
nmap <silent> <C-f> :TestFile <CR>
nmap <silent> <C-x> :TestLast <CR>
let test#strategy = "neovim"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-TEST-CONSOLE CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vrc_curl_opts = {
  \ '-i': '',
\}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>r :Git refactor <CR>
nmap <silent> <C-h> :tabprevious <CR>
nmap <silent> <C-l> :tabnext <CR>
nmap <silent> <C-n> :tabnew <CR>

" Disable ex mode
map q: <Nop>
nnoremap Q <nop>

nnoremap <Leader>vn :e ~/code/notes.md<CR>
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>
inoremap jj <Esc>                             " Quick exit of insert mode
tnoremap jj <C-\><C-n>                        " Quick exit of insert mode while in terminal emulator
nnoremap <leader>cp :let @*=expand("%:p")<CR> " Copy full file path of current buffer to clipboard
" vmap <silent> gc <C-V>^I#<Space><Esc> " Comment out lines
" nmap - :e .<CR>                       " Start Netrw with '-'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto-continue comment chars after ENTER, but not after hitting 'o' or 'O'
au FileType * set formatoptions-=c formatoptions-=o


" Typo forgiveness
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>
command! -bang W w<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>
command! Gblame Git blame

lua <<EOF

-- OPTIONS
vim.cmd 'colorscheme sonokai'

opt = vim.opt
opt.autoread = true
opt.background = 'dark'
opt.clipboard = 'unnamed'
opt.expandtab = true
opt.ignorecase = true
opt.inccommand = 'nosplit'
opt.mouse = 'a'
opt.number = true
opt.shiftwidth = 2
opt.showtabline = 1
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 2
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.wrap = false

--  NVIM-TREESITTER
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- LUALINE
require'lualine'.setup()

-- TROUBLE
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

vim.lsp.set_log_level("debug")
local nvim_lsp = require'lspconfig'

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end  -- Mappings.
  local opts = { noremap=true, silent=true }  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

nvim_lsp.solargraph.setup {
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
EOF
