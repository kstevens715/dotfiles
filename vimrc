" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set nowrap

" =============== Pathogen Initialization ===============
" This loads all the plugins in ~/.vim/bundle
" Use tpope's pathogen plugin to manage all other plugins

  call pathogen#infect()
  call pathogen#helptags()

" ================= Keyboard Mappings ===============
inoremap jj <Esc> 

" Map "\t" to open up command-t, but first perform a refresh of the tree.
nnoremap <silent> <Leader>t :CommandTFlush<CR>:CommandT<CR>

" Map "\y" to open up command-t to show open buffers.
nnoremap <silent> <Leader>b :CommandTBuffer<CR>

" Use Alt-Arrow to move between splits
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Use Shift-Arrow to move between tabs
nmap <silent> <S-l> :tabnext <CR>
nmap <silent> <S-h> :tabprevious <CR>
nmap <silent> <C-n> :tabnew <CR>

" The following three commands enables pasting code snippets
" using F2 key (disables auto-indenting)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Use Leader-S to save current file if it's been modified.
inoremap <F3> <c-o>:w<cr>

" ruby-debugger mappings
" map <Leader>db  :call g:RubyDebugger.toggle_breakpoint()<CR>
" map <Leader>dv  :call g:RubyDebugger.open_variables()<CR>
" map <Leader>dm  :call g:RubyDebugger.open_breakpoints()<CR>
" map <Leader>dt  :call g:RubyDebugger.open_frames()<CR>
" map <Leader>ds  :call g:RubyDebugger.step()<CR>
" map <Leader>df  :call g:RubyDebugger.finish()<CR>
" map <Leader>dn  :call g:RubyDebugger.next()<CR>
" map <Leader>dc  :call g:RubyDebugger.continue()<CR>
" map <Leader>de  :call g:RubyDebugger.exit()<CR>
" map <Leader>dd  :call g:RubyDebugger.remove_breakpoints()<CR>

" =================== Misc. Options =================

" Point to Ubuntu's Ack executable
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

set backspace=2         " Backspace not working without this.
set number              " Use line numbers.
" set colorcolumn=81      " Helps me keep lines to 80 chars.

" Ignore some file patterns in commandt.
set wildignore+=tmp/**
set wildignore+=doc/**
set wildignore+=db/sphinx/**
set wildignore+=coverage/**

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
colorscheme molokai

