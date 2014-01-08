nnoremap <silent> <Leader>p :CtrlPBuffer<CR>

" Quick exit of insert mode
inoremap jj <Esc>

" User CTRL-f for searching project
noremap <C-F> <esc>:Ack<space>
inoremap <C-F> <esc>:Ack<space>

" Use Shift-movement to switch between windows.
nmap <silent> <S-h> :wincmd h <CR>
nmap <silent> <S-j> :wincmd j <CR>
nmap <silent> <S-k> :wincmd k <CR>
nmap <silent> <S-l> :wincmd l <CR>

" Use CTRL-movement to move between tabs.
nmap <silent> <C-l> :tabnext <CR>
nmap <silent> <C-h> :tabprevious <CR>
nmap <silent> <C-n> :tabnew <CR>

" Edit Vim configs
nmap <leader>a :vsp<CR>:e ~/dot-files/vim/abbreviations.vim<CR>
nmap <leader>b :vsp<CR>:e ~/dot-files/vim/bundle.vim<CR>
nmap <leader>v :vsp<CR>:e ~/dot-files/vim/vimrc<CR>

" Paste onto new line
nmap P :pu <CR>

" The following three commands enables pasting code snippets
" using F2 key (disables auto-indenting)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
