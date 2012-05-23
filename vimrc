" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" =============== Pathogen Initialization ===============
" This loads all the plugins in ~/.vim/bundle
" Use tpope's pathogen plugin to manage all other plugins

  call pathogen#infect()
  call pathogen#helptags()

" ================= Keyboard Mappings ===============
inoremap jj <Esc> 

" These are defaults anyway, but here to prevent overwriting.
nnoremap <silent> <Leader>t :CommandT<CR>
nnoremap <silent> <Leader>b :CommandTBuffer<CR>

" Use Alt-Arrow to move between splits
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" The following three commands enables pasting code snippets
" using F2 key (disables auto-indenting)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" =================== Misc. Options =================
set wildignore+="tmp/**"
set backspace=2         " Backspace not working without this.
set number              " Use line numbers.
set colorcolumn=81      " Helps me keep lines to 80 chars.
set wildignore+=tmp/**  " Ignore temp files in Command-T
syntax on               " Syntax highlighting.

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Indentation ======================
filetype indent plugin on
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
colorscheme murphy

