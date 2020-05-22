call plug#begin('~/.local/share/nvim/plugged')

Plug 'ayu-theme/ayu-vim'
Plug 'bling/vim-airline'
Plug 'cloudhead/neovim-fuzzy'
Plug 'diepm/vim-rest-console'
Plug 'janko/vim-test'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/vim-gist'
Plug 'mattn/webapi-vim'
Plug 'mechatroner/rainbow_csv'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'wfleming/vim-codeclimate'

call plug#end()

" Color scheme
set termguicolors
let ayucolor="dark"
colorscheme ayu
command SwitchColor let ayucolor=( ayucolor == "dark"? "light" : "dark" ) | colorscheme ayu

nmap <leader>f :FuzzyGrep<CR>
nmap <leader>t :FuzzyOpen<CR>
set number " Line numbers on
filetype plugin on
set colorcolumn=120

" Quick exit of insert mode
inoremap jj <Esc>
" Quick exit of insert mode while in terminal emulator
tnoremap jj <C-\><C-n>

map <C-[> :pop <CR>

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

" Auto-continue comment chars after ENTER, but not after hitting 'o' or 'O'
au FileType * set formatoptions-=c formatoptions-=o

" Tab navigation
nmap <silent> <C-h> :tabprevious <CR>
nmap <silent> <C-l> :tabnext <CR>
nmap <silent> <C-n> :tabnew <CR>

" Test shortcuts
nmap <silent> <C-c> :TestNearest <CR>
nmap <silent> <C-f> :TestFile <CR>
nmap <silent> <C-x> :TestLast <CR>

let test#strategy = "neovim"

" Toggle F2 for paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Toggle F3 for spell checking
map <F3> :setlocal spell! spelllang=en_us<CR>
imap <F3> <C-o>:setlocal spell! spelllang=en_us<CR>

map <F4> :silent execute '![ -f "%:p" ] && open -R "%:p" \|\| open "%:p:h"'<CR>

" Leader-s to check Ruby syntax
autocmd FileType ruby map <leader>s :w<CR>:!ruby -c %<CR>

" Typo forgiveness
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>
command! -bang W w<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>

command Ghist 0Glog

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

ab pry binding.pry

if has("autocmd")
  augroup templates
    autocmd BufNewFile *.rb 0r ~/dot-files/skeleton.rb
  augroup END
endif
