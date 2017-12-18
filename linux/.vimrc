" Load plugins
execute pathogen#infect()

" Detect filetype and indentation
filetype plugin indent on

" Enable syntax hilights
syntax enable

" Set colors
set termguicolors
colorscheme apprentice

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

" Configure NERDTree binds and autoclose if only it is active
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Use deoplete
let g:deoplete#enable_at_startup = 1

" Configure LanguageClient
set signcolumn=yes
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }
autocmd BufWrite *.rs call LanguageClient_textDocument_formatting()
