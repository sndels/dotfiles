" Load plugins
execute pathogen#infect()

" Detect filetype and indentation
filetype plugin indent on

" Enable syntax hilights
syntax enable

" Disable vi-compatibility
set nocompatible

" Set line numbers
set number
set relativenumber

" Start searching while typing and hilight
set incsearch
set hlsearch

" Enable mouse
set mouse=a

" Menu completion
set wildmenu wildmode=longest,list

" Configure indentation behaviour
set backspace=indent,eol,start
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Disable backup files
set nobackup
set nowb
set noswapfile

" Hide buffer if unsaved
set hidden

" Bind tab navigation
map <C-n> :tabn<CR>
imap <C-b> :tabp<CR>
map <C-e> :tabe

" Highlight trailing whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list

" Configure airline
let g:airline_theme='minimalist'
let g:airline_powerline_fonts=1
