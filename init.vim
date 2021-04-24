" ========== PLUGINS ==========
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'              " Shows git status in gutter for lines. More things are possible.
Plug 'bfredl/nvim-miniyank'                " Fixes issues with system clipboard
Plug 'diepm/vim-rest-console'              " Vim REST client
Plug 'folke/tokyonight.nvim'               " Theme
Plug 'bronson/vim-trailing-whitespace'     " Highlight trailing whitesplace
Plug 'PeterRincker/vim-searchlight'        " Highlight current match in different color
Plug 'hoob3rt/lualine.nvim'                " Status line
Plug 'kyazdani42/nvim-web-devicons'        " I think this helps add icons to status line
Plug 'lewis6991/gitsigns.nvim'             " Shows last Git commit message for current line
Plug 'nvim-lua/plenary.nvim'               " Dependency for gitsigns
Plug 'mattn/vim-gist'                      " Make Gists from Vim
Plug 'mattn/webapi-vim'                    " Dependency for vim-gist
Plug 'sheerun/vim-polyglot'                " Lazily adds language support
Plug 'kchmck/vim-coffee-script'            " CoffeeScript syntax highlighting
Plug 'wfleming/vim-codeclimate'            " Analyze files using Code Climate plugin
Plug 'psf/black', { 'branch': 'stable' }   " Format Python code with Black
Plug 'ngmy/vim-rubocop'                    " Rubocop code quality analysis
Plug 'tpope/vim-bundler'                   " I think this is to :Bopen a gem
Plug 'tpope/vim-commentary'                " Comment out code with gc
Plug 'tpope/vim-endwise'                   " Automatically insert `end` after `def`
Plug 'tpope/vim-fugitive'                  " Git plugin
Plug 'tpope/vim-rails'                     " Rails plugin
Plug 'junegunn/vim-easy-align'             " I use this to align Ruby hash values
Plug 'tpope/vim-rhubarb'                   " GitHub plugin for things like GBrowse
Plug 'tpope/vim-vinegar'                   " Enhancements to netrw like '-'
Plug 'vim-test/vim-test'                   " Test runner

" LSP and fuzzy finder plugins
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}

call plug#end()

" ========== PLUGIN SETTINGS ==========

" coc
let g:coc_global_extensions = [
      \'coc-solargraph',
      \'coc-json'
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

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" fzf
map <leader>t :GFiles<CR>
map <D-p> :GFiles<CR>
map <leader>b :Buffers<CR>
map <leader>c :BCommits <CR>
map <leader>f :Rg <CR>
map <leader>g :Tags <CR>

let g:fzf_buffers_jump = 1
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

" nvim-miniyank
" See: https://github.com/neovim/neovim/issues/13940
set clipboard=unnamed
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-rest-console
let g:vrc_allow_get_request_body = 1
let g:vrc_output_buffer_name = '__VRC_OUTPUT.json'
let g:vrc_response_default_content_type = 'application/json'
let g:vrc_show_command = 0
let g:vrc_curl_opts = {
  \ '-sS': ''
\}

" vim-test
nmap <silent> <C-c> :TestNearest <CR>
nmap <silent> <C-f> :TestFile <CR>
nmap <silent> <C-x> :TestLast <CR>
let test#strategy = "neovim"

" ========== STYLE / COLOR ==========
let g:tokyonight_style = "night"
colorscheme tokyonight
let python_highlight_all = 1
let g:lualine = {
    \'options' : {
    \  'theme' : 'tokyonight',
    \  'section_separators' : ['', ''],
    \  'component_separators' : ['', ''],
    \  'icons_enabled' : v:true,
    \},
    \'sections' : {
    \  'lualine_a' : [ ['mode', {'upper': v:true,},], ],
    \  'lualine_b' : [ ['branch', {'icon': '',}, ], ],
    \  'lualine_c' : [ ['filename', {'file_status': v:true,},], ],
    \  'lualine_x' : [ 'encoding', 'fileformat', 'filetype' ],
    \  'lualine_y' : [ 'progress' ],
    \  'lualine_z' : [ 'location'  ],
    \},
    \'inactive_sections' : {
    \  'lualine_a' : [  ],
    \  'lualine_b' : [  ],
    \  'lualine_c' : [ 'filename' ],
    \  'lualine_x' : [ 'location' ],
    \  'lualine_y' : [  ],
    \  'lualine_z' : [  ],
    \},
    \'extensions' : [ 'fzf', 'fugitive' ],
    \}
lua require('lualine').setup{}
lua require('gitsigns').setup{}
Gitsigns toggle_current_line_blame


highlight IncSearch guibg=green ctermbg=green term=underline

" ========== ABBREVIATIONS ==========
ab fsl # frozen_string_literal: true
ab pry binding.pry
ab rth require 'test_helper'
ab tcase ActiveSupport::TestCase

" open / reload config
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>

" Quick exit of insert mode
inoremap jj <Esc>
" Quick exit of insert mode while in terminal emulator
tnoremap jj <C-\><C-n>

" Auto-continue comment chars after ENTER, but not after hitting 'o' or 'O'
au FileType * set formatoptions-=c formatoptions-=o

" Tab navigation
nmap <silent> <C-h> :tabprevious <CR>
nmap <silent> <C-l> :tabnext <CR>
nmap <silent> <C-n> :tabnew <CR>

" Toggle F3 for spell checking
map <F3> :setlocal spell! spelllang=en_us<CR>
imap <F3> <C-o>:setlocal spell! spelllang=en_us<CR>

map <F4> :silent execute '![ -f "%:p" ] && open -R "%:p" \|\| open "%:p:h"'<CR>

" Typo forgiveness
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>
command! -bang W w<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>

" Disable ex mode
map q: <Nop>
nnoremap Q <nop>

command! Ghist 0Glog

" Option Settings
set colorcolumn=150
set cursorline
set expandtab
set ignorecase
set inccommand=nosplit " Preview substitutions
set mouse=a            " Use mouse for scrolling/copying
set nowrap
set number
set shiftwidth=2
set smartcase
set smartindent
set softtabstop=2
set tabstop=2
set termguicolors     " enable true colors support

let g:ruby_indent_access_modifier_style="indent"
