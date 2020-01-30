call plug#begin('~/.local/share/nvim/plugged')
" Comment / Uncomment
Plug 'tpope/vim-commentary'

" Git stuff like Gblame
Plug 'tpope/vim-fugitive'

" Status bar
Plug 'bling/vim-airline'

" File finder
Plug 'cloudhead/neovim-fuzzy'
nmap <leader>t :FuzzyOpen<CR>

" Syntax highlighting for TypeScript
Plug 'leafgarland/typescript-vim'

" Color theme
Plug 'sickill/vim-monokai'

" REST client
Plug 'diepm/vim-rest-console'

" Searching (make sure the_silver_searcher is installed first)
Plug 'mileszs/ack.vim'
let g:ackprg = 'ag --vimgrep'
let g:ackpreview = 1
nmap <leader>f :Ack<space>

Plug 'chrisbra/csv.vim'

call plug#end()

colorscheme monokai
set number " Line numbers on
filetype plugin on
set colorcolumn=120

nmap <silent> <C-h> :tabprevious <CR>
nmap <silent> <C-l> :tabnext <CR>
nmap <silent> <C-n> :tabnew <CR>

" Quick exit of insert mode
inoremap jj <Esc>

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Autoformat JSON
com! FormatJSON %!python3 -m json.tool

" Vim REST client settings
let g:vrc_allow_get_request_body = 1
let g:vrc_output_buffer_name = '__VRC_OUTPUT.json'
let g:vrc_response_default_content_type = 'application/json'
let g:vrc_show_command = 0
let g:vrc_curl_opts = {
  \ '-sS': ''
\}

" File type aliases for highlighting
au BufNewFile,BufRead *.mustache set filetype=html
au BufNewFile,BufRead *.psql set filetype=sql
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead Dockerfile* set filetype=dockerfile
au BufNewFile,BufRead Gemfile* set filetype=ruby
au BufNewFile,BufRead Guardfile set filetype=ruby

" Tab navigation
nmap <silent> <C-h> :tabprevious <CR>
nmap <silent> <C-l> :tabnext <CR>
nmap <silent> <C-n> :tabnew <CR>

" Toggle F2 for paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Toggle F3 for spell checking
map <F3> :setlocal spell! spelllang=en_us<CR>
imap <F3> <C-o>:setlocal spell! spelllang=en_us<CR>

" Typo forgiveness
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>
command! -bang W w<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>

" Smart case searching
set ignorecase
set smartcase

" Indentation
filetype indent plugin on
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

let g:ruby_indent_access_modifier_style="indent"

" \\p to insert binding.pry
map <leader><leader>p Obinding.pry if true<esc>
