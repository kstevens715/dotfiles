" ========== PLUGINS ==========
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sainnhe/sonokai'
Plug 'tpope/vim-fugitive'                   " Git plugin
Plug 'vim-test/vim-test'                    " Test runner

" I think the only thing from this I use is the ability to go from
" from test file to source file and back.
" An alternate idea is something like: https://github.com/garybernhardt/dotfiles/blob/e0786e861687af64b7ea3f1b9f2b66a8bfbfe6bf/.vimrc#L400-L428
Plug 'tpope/vim-rails'

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
map <leader>t :GFiles<CR>
map <leader>b :Buffers<CR>
map <leader>c :BCommits <CR>
map <leader>f :Rg <CR>
map <leader>g :Tags <CR>

let g:fzf_buffers_jump = 1

" vim-test
nmap <silent> <C-c> :TestNearest <CR>
nmap <silent> <C-f> :TestFile <CR>
nmap <silent> <C-x> :TestLast <CR>
nmap <CR> :TestNearest <CR>
let test#strategy = "neovim"


" ========== STYLE / COLOR ==========
colorscheme sonokai

highlight IncSearch guibg=green ctermbg=green term=underline

nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>
inoremap jj <Esc>                     " Quick exit of insert mode
tnoremap jj <C-\><C-n>                " Quick exit of insert mode while in terminal emulator
vmap <silent> gc <C-V>^I#<Space><Esc> " Comment out lines
nmap - :e .<CR>                       " Start Netrw with '-'

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
set clipboard=unnamed
set expandtab
set ignorecase
set inccommand=nosplit " Preview substitutions
set mouse=a            " Use mouse for scrolling/copying
set nofoldenable       " Don't fold MD sections
set noswapfile
set nowrap
set shiftwidth=2
set showtabline=1
set smartcase
set smartindent
set softtabstop=2
set tabstop=2
