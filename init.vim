" ========== PLUGINS ==========
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'               " Shows git status in gutter for lines. More things are possible.
Plug 'aklt/plantuml-syntax'                 " UML syntax highlighting
Plug 'bfredl/nvim-miniyank'                 " Fixes issues with system clipboard
Plug 'diepm/vim-rest-console'               " Vim REST client
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim'                     " needed for previews
Plug 'junegunn/vim-easy-align'              " I use this to align Ruby hash values
Plug 'morhetz/gruvbox'                      " Color scheme
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/vim-slumlord'              " UML / sequence diagrams
Plug 'tpope/vim-commentary'                 " Comment out code with gc
Plug 'tpope/vim-endwise'                    " Automatically insert `end` after `def`
Plug 'tpope/vim-fugitive'                   " Git plugin
Plug 'tpope/vim-rails'                      " Rails plugin
Plug 'tpope/vim-rhubarb'                    " GitHub plugin for things like GBrowse
Plug 'tpope/vim-vinegar'                    " Enhancements to netrw like '-'
Plug 'vim-airline/vim-airline'
Plug 'vim-test/vim-test'                    " Test runner

call plug#end()

" ========== PLUGIN SETTINGS ==========
let g:dashboard_default_executive ='fzf'
" coc
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

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" vim-rest-console
let g:vrc_allow_get_request_body = 1
let g:vrc_output_buffer_name = '__VRC_OUTPUT.json'
let g:vrc_response_default_content_type = 'application/json'
let g:vrc_show_command = 0
let g:vrc_curl_opts = {
  \ '-sS': ''
\}

" fzf
map <leader>t :GFiles<CR>
map <D-p> :GFiles<CR>
map <leader>b :Windows<CR>
map <leader>c :BCommits <CR>
map <leader>f :Rg <CR>
map <leader>g :Tags <CR>

let g:fzf_buffers_jump = 1

" nvim-miniyank
" See: https://github.com/neovim/neovim/issues/13940
set clipboard=unnamed
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

" vim-test
nmap <silent> <C-c> :TestNearest <CR>
nmap <silent> <C-f> :TestFile <CR>
nmap <silent> <C-x> :TestLast <CR>
let test#strategy = "neovim"
let test#python#pytest#options = '-v'

" ========== STYLE / COLOR ==========
let g:lumiere_dim_inactive_windows = 1
set termguicolors     " enable true colors support
set background=light
colorscheme gruvbox
let python_highlight_all = 1
let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_contrast_dark = 'soft'

highlight IncSearch guibg=green ctermbg=green term=underline

" ========== ABBREVIATIONS ==========
ab pry binding.pry

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
set number
set colorcolumn=150
set cursorline
set expandtab
set ignorecase
set inccommand=nosplit " Preview substitutions
set mouse=a            " Use mouse for scrolling/copying
set nowrap
set shiftwidth=2
set showtabline=0
set smartcase
set smartindent
set softtabstop=2
set tabstop=2

let g:ruby_indent_access_modifier_style="indent"
