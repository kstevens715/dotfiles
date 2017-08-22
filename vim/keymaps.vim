nnoremap <silent> <Leader>p :CtrlPBuffer<CR>

" Quick exit of insert mode
inoremap jj <Esc>

" Make comma an alias for leader, as some people prefer this
nmap , <leader>

" CtrlP Helpers
nmap <C-P> <esc>:CtrlP <CR>
nmap <leader>b :ToggleBufExplorer<CR>

" User CTRL-f for searching project
noremap <C-F> <esc>:Ack<space>
inoremap <C-F> <esc>:Ack<space>

nmap <silent> <C-h> :tabprevious <CR>
nmap <silent> <C-l> :tabnext <CR>
nmap <silent> <C-n> :tabnew <CR>

" Edit Vim configs
nmap <leader>a :vsp<CR>:e ~/dot-files/vim/abbreviations.vim<CR>
nmap <leader>v :vsp<CR>:e ~/dot-files/vim/vimrc<CR>

" The following three commands enables pasting code snippets
" using F2 key (disables auto-indenting)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" F6 toggles spell checking
map <F6> :setlocal spell! spelllang=en_us<CR>
imap <F6> <C-o>:setlocal spell! spelllang=en_us<CR>

" =============== Command Aliases ===============
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>
command! -bang W w<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>
