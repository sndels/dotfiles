" Load plugins
execute pathogen#infect()

call plug#begin()

" Code navigation and completion
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}

" Search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

" Themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasiser/vim-code-dark'

call plug#end()

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

" Configure themes
let g:codedark_transparent=1
colorscheme codedark
let g:airline_theme='codedark'
let g:airline_powerline_fonts=1

" Configure LSP and completions
lua <<EOF
    local lsp = require "lspconfig"
    local coq = require "coq"

    lsp.clangd.setup(coq.lsp_ensure_capabilities({ cmd = {"clangd-15"} }))

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', '<f12>', vim.lsp.buf.declaration, opts)
        -- ctrl-f12
        vim.keymap.set('n', '<f36>', vim.lsp.buf.definition, opts)
      end,
    })
EOF

