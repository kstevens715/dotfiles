set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-fugitive'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'nono/vim-handlebars'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'vim-scripts/dbext.vim'

Plugin 'sickill/vim-monokai'

call vundle#end()
filetype plugin indent on     " required!
