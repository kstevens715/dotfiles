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

Plug 'MattesGroeger/vim-bookmarks'
Plug 'airblade/vim-gitgutter'
Plug 'diepm/vim-rest-console'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
set background=dark
set termguicolors
let g:sonokai_style = 'espresso'

colorscheme sonokai
highlight IncSearch guibg=green ctermbg=green term=underline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread
set clipboard=unnamed
set expandtab
set ignorecase
set inccommand=nosplit " Preview substitutions
set mouse=a            " Use mouse for scrolling/copying
set noswapfile
set nowrap
set number
set shiftwidth=2
set showtabline=1
set smartcase
set smartindent
set softtabstop=2
set tabstop=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NVIM-TREESITTER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua <<EOF
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
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LUALINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << END
require'lualine'.setup()
END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-RUBY CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ruby_indent_assignment_style = 'variable'
" Indent private methods:
" let g:ruby_indent_access_modifier_style = 'indent'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC.nvim CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = [
      \'coc-solargraph',
      \'coc-json',
      \'coc-pyright'
\]

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <leader>rn <Plug>(coc-rename)
command! -nargs=0 Format :call CocAction('format')

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TELESCOPE CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>c <cmd>Telescope git_commits<cr>
nnoremap <leader>t <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>:
nnoremap <leader>f <cmd>Telescope live_grep<cr>:

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
