" ========== PLUGINS ==========
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'               " Shows git status in gutter for lines. More things are possible.
Plug 'diepm/vim-rest-console'               " Vim REST client
Plug 'godlygeek/tabular'                    " Needed for vim-markdown
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim'                     " needed for previews
Plug 'junegunn/vim-easy-align'              " I use this to align Ruby hash values
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'plasticboy/vim-markdown'
Plug 'sainnhe/sonokai'
Plug 'tpope/vim-commentary'                 " Comment out code with gc
Plug 'tpope/vim-endwise'                    " Automatically insert `end` after `def`
Plug 'tpope/vim-fugitive'                   " Git plugin
Plug 'tpope/vim-rails'                      " Rails plugin
Plug 'tpope/vim-rhubarb'                    " GitHub plugin for things like GBrowse
Plug 'tpope/vim-vinegar'                    " Enhancements to netrw like '-'
Plug 'tricktux/pomodoro.vim'
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
map <leader>b :Buffers<CR>
map <leader>c :BCommits <CR>
map <leader>f :Rg <CR>
map <leader>g :Tags <CR>

let g:fzf_buffers_jump = 1

set clipboard=unnamed

" vim-test
nmap <silent> <C-c> :TestNearest <CR>
nmap <silent> <C-f> :TestFile <CR>
nmap <silent> <C-x> :TestLast <CR>
nmap <CR> :TestNearest <CR>
let test#strategy = "neovim"
let test#python#pytest#options = '-v'

nnoremap <Leader>d :e ~/Documents/TODO.md<CR>
" Pomodoro
map <leader>p :PomodoroStart <CR>
call airline#parts#define_raw('pomodoro', '%#ErrorMsg#%{pomo#status_bar()}%#StatusLine#')
let g:airline_section_z = airline#section#create_right(['pomodoro'])
let g:pomodoro_notification_cmd = "mpg123 -q ~/dot-files/beep-01a.mp3"

" Duration of a pomodoro in minutes (default: 25)
let g:pomodoro_time_work = 25

" Duration of a break in minutes (default: 5)
let g:pomodoro_time_slack = 5

" Log completed pomodoros, 0 = False, 1 = True (default: 0)
let g:pomodoro_do_log = 0

" Path to the pomodoro log file (default: /tmp/pomodoro.log)
" let g:pomodoro_log_file = "~/dot-files/pomodoro.log"


" ========== STYLE / COLOR ==========
let g:lumiere_dim_inactive_windows = 1
set termguicolors     " enable true colors support
set background=dark
let g:sonokai_style = 'shusia'
let g:sonokai_diagnostic_text_highlight = 1
colorscheme sonokai
let python_highlight_all = 1
let g:airline_theme = 'sonokai'

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

let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_access_modifier_style="indent"
