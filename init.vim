"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
" Disable compatibility with vi which can cause unexpected issues.
set nocompatible
set guifont=Hack\ Nerd\ Font\ Mono:h11
" Enable type file detection. Vim will be able to try to detect the type of file is use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to the file.
set number

" Add relative number to see how many lines above and below you have
set relativenumber

"Highlight cursor line underneath the cursor horizontally.
set cursorline


" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" This will add indents when convenient
set smartindent

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

  Plug 'dense-analysis/ale'

  Plug 'preservim/nerdtree'

  Plug 'jelera/vim-javascript-syntax'

  Plug 'pangloss/vim-javascript'

  Plug 'nvim-telescope/telescope.nvim'

  Plug 'nvim-lua/plenary.nvim'

  Plug 'nvim-lua/popup.nvim'

  Plug 'sheerun/vim-polyglot'

  Plug 'itchyny/lightline.vim'
  Plug 'maximbaz/lightline-ale'
  
  Plug 'jiangmiao/auto-pairs'
  
  Plug 'damage220/vim-finder'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " git plugins
  Plug 'tpope/vim-fugitive'
  
  " Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Theme
  Plug 'doums/darcula'
  
  " Add git branch name to the status line
  Plug 'itchyny/vim-gitbranch'
  
  " Add icons for files in the tree
  Plug 'ryanoasis/vim-devicons'

  " Block comments plugin --> use it with gcc
  Plug 'tpope/vim-commentary'

  " Add inline color visualization
  Plug 'norcalli/nvim-colorizer.lua'
call plug#end()

" Color scheme
colorscheme darcula
set termguicolors     " enable true colors support

lua require'colorizer'.setup()

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
"set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }
" }}}

" MAPS =----------------------------------------------------------------
let mapleader = " "
nnoremap <Leader>nt :NERDTreeToggle <CR>
nnoremap <leader>fs :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>p :Files <CR>

" FZF key bindings
nnoremap <C-f> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> <Leader>f :Rg<CR>

" use <tab> for trigger completion and navigate to the next complete item
 function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~ '\s'
 endfunction

 inoremap <silent><expr> <Tab>
       \ pumvisible() ? "\<C-n>" :
       \ <SID>check_back_space() ? "\<Tab>" :
       \ coc#refresh()
