" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set nowrap

" =============== RSpec By doing LEADER-r on a spec  ===============
function! RSpecFile()
  execute("!clear && spring rspec " . expand("%p"))
endfunction

map <leader>R :call RSpecFile() <CR>
command! RSpecFile call RSpecFile()

function! RSpecCurrent()
  execute("!clear && spring rspec " . expand("%p") . ":" . line("."))
endfunction

map <leader>r :call RSpecCurrent() <CR>
command! RSpecCurrent call RSpecCurrent()

" =============== Pathogen Initialization ===============
" This loads all the plugins in ~/.vim/bundle
" Use tpope's pathogen plugin to manage all other plugins

  call pathogen#infect()
  call pathogen#helptags()

" =============== Configure Powerline ===============

  set rtp+=$HOME/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/

  python from powerline.vim import setup as powerline_setup
  python powerline_setup()
  python del powerline_setup

  set laststatus=2 " Always show a statusline

" =============== Command Aliases ===============
" See http://blog.sanctum.geek.nz/vim-command-typos/ for possibly better
" idea.
command WQ wq
command Wq wq
command W w
command! -bang Q q<bang>
command Todo execute "Ack TODO:"
command Fixme execute "Ack FIXME:"

" ================= Keyboard Mappings ===============
inoremap jj <Esc> 

" Map "\t" to open up command-t, but first perform a refresh of the tree.
nnoremap <silent> <Leader>t :CommandTFlush<CR>:CommandT<CR>

" Map "\g" to search ctags with command-t
nnoremap <silent> <Leader>g :CommandTTag<CR>

" Map "\y" to open up command-t to show open buffers.
nnoremap <silent> <Leader>b :CommandTBuffer<CR>

" Use Shift-movement to switch between windows.
nmap <silent> <S-h> :wincmd h <CR>
nmap <silent> <S-j> :wincmd j <CR>
nmap <silent> <S-k> :wincmd k <CR>
nmap <silent> <S-l> :wincmd l <CR>

" Use CTRL-movement to move between tabs.
nmap <silent> <C-l> :tabnext <CR>
nmap <silent> <C-h> :tabprevious <CR>
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


" psql files should be highlighted as sql
au BufNewFile,BufRead *.psql set filetype=sql

" Point to Ubuntu's Ack executable
let g:ackprg="ack-grep -H --nocolor --nogroup --column --ignore-dir=tmp --ignore-dir=public --ignore-dir=vendor"

set backspace=2         " Backspace not working without this.
set number              " Use line numbers.

" =================== Liaison Helpers =================
set colorcolumn=141

" Ignore some file patterns in commandt.
set wildignore+=tmp/**
set wildignore+=doc/**
set wildignore+=db/sphinx/**
set wildignore+=coverage/**
set wildignore+=node_modules/**
set wildignore+=public/**

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

" ================ Theme ======================
set t_Co=256            " Force 256 colors to get Molokai theme to render correctly in terminal.

syntax on               " Syntax highlighting.
colorscheme Monokai     " https://github.com/tomasr/molokai


" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
