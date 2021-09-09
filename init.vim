" ========== PLUGINS ==========
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'sainnhe/sonokai'
Plug 'tpope/vim-fugitive'                   " Git plugin
Plug 'tpope/vim-rails'                      " Rails plugin
Plug 'tpope/vim-vinegar'                    " Enhancements to netrw like '-'
Plug 'vim-test/vim-test'                    " Test runner

call plug#end()

" ========== PLUGIN SETTINGS ==========
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_access_modifier_style = 'indent'

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

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" fzf
map <leader>t :Telescope git_files<CR>
map <leader>b :Telescope buffers<CR>
map <leader>c :BCommits <CR>
map <leader>f :Telescope live_grep<CR>
map <leader>g :Telescope tags <CR>

let g:fzf_buffers_jump = 1

set clipboard=unnamed

" vim-test
nmap <silent> <C-c> :TestNearest <CR>
nmap <silent> <C-f> :TestFile <CR>
nmap <silent> <C-x> :TestLast <CR>
nmap <CR> :TestNearest <CR>
let test#strategy = "neovim"
let test#python#pytest#options = '-v'


" ========== STYLE / COLOR ==========
set termguicolors     " enable true colors support
let g:sonokai_style = 'shusia'
colorscheme sonokai

highlight IncSearch guibg=green ctermbg=green term=underline

" ========== ABBREVIATIONS ==========
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
set conceallevel=2     " Don't display URLs in MD
set cursorline
set expandtab
set ignorecase
set inccommand=nosplit " Preview substitutions
set mouse=a            " Use mouse for scrolling/copying
set nofoldenable       " Don't fold MD sections
set nowrap
set shiftwidth=2
set showtabline=1
set smartcase
set smartindent
set softtabstop=2
set tabstop=2
