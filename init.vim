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


  Plug 'pangloss/vim-javascript'
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

  Plug 'nvim-telescope/telescope.nvim'

  Plug 'nvim-lua/plenary.nvim'

  Plug 'nvim-lua/popup.nvim'

  Plug 'sheerun/vim-polyglot'

  Plug 'itchyny/lightline.vim'
  Plug 'maximbaz/lightline-ale'

  Plug 'prettier/prettier'
  
  Plug 'jiangmiao/auto-pairs'
  
  Plug 'damage220/vim-finder'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " git plugins
  Plug 'tpope/vim-fugitive'
  
  " Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Themes
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
  Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
  " Add git branch name to the status line
  Plug 'itchyny/vim-gitbranch'
  
  " Add icons for files in the tree
  Plug 'ryanoasis/vim-devicons'

  " Block comments plugin --> use it with gcc
  Plug 'tpope/vim-commentary'

  " Add inline color visualization
  Plug 'norcalli/nvim-colorizer.lua'

  " Add buffer tabs
  Plug 'mengelbrecht/lightline-bufferline'

  " Add Git conlicts visualizer
  Plug 'akinsho/git-conflict.nvim'

  " Add context visualization
  Plug 'wellle/context.vim'
  
  " Add better comments plugin
  Plug 'jbgutierrez/vim-better-comments'
  
  " Readme preview
  Plug 'shime/vim-livedown' 

  " Code actions menu
  Plug 'weilbith/nvim-code-action-menu' 

  " Prettier
  Plug 'neoclide/coc-prettier'

  " Python LSP
  Plug 'vim-python/python-syntax' 

  " LSP Manager
  Plug 'neovim/nvim-lspconfig'
  Plug 'kabouzeid/nvim-lspinstall'

  Plug 'wuelnerdotexe/vim-astro'

  " Package Manager
  Plug 'vuki656/package-info.nvim'

  Plug 'prisma/vim-prisma'

call plug#end()

" Color scheme
set termguicolors
colorscheme catppuccin-macchiato
" colorscheme embark

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
      \ 'colorscheme': 'one',
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ }
let g:lightline#bufferline#smart_path=1
let g:lightline#bufferline#shorten_path=0
" }}}

" LSP CONFIG ON INIT ---------- {

lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.tailwindcss.setup{}
require'lspconfig'.perlpls.setup{}
require'lspconfig'.astro.setup{}
EOF

" }
"BUFFER LINE ---------------------------------------------------{
set showtabline=2
let g:lightline#bufferline#show_number=2
" ------------------------------ }

" CONTEXT.VIM CONFIG -----------------------{

let g:context_border_char='━'
let g:context_highlight_normal='PMenu'
let g:context_highlight_tag='<hide>'

" }

" MAPS =----------------------------------------------------------------

let mapleader = " "
nnoremap <Leader>nt :NERDTreeFind <CR>
nnoremap <Leader>nx :NERDTreeToggle <CR>
nnoremap <leader>fs :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>p :FZF <CR>
nnoremap <leader>gr :<C-U>call CocActionAsync('jumpReferences')<CR>
" show function defs
nnoremap <leader>rp :<C-U>:CocCommand prettier.formatFile<CR>
" FZF key bindings
nnoremap <C-f> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> <Leader>f :Rg<CR>

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Manage buffertabs with numbers and c-number deletes the tab number
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)

nmap <Leader>c1 <Plug>lightline#bufferline#delete(1)
nmap <Leader>c2 <Plug>lightline#bufferline#delete(2)
nmap <Leader>c3 <Plug>lightline#bufferline#delete(3)
nmap <Leader>c4 <Plug>lightline#bufferline#delete(4)
nmap <Leader>c5 <Plug>lightline#bufferline#delete(5)
nmap <Leader>c6 <Plug>lightline#bufferline#delete(6)
nmap <Leader>c7 <Plug>lightline#bufferline#delete(7)
nmap <Leader>c8 <Plug>lightline#bufferline#delete(8)
nmap <Leader>c9 <Plug>lightline#bufferline#delete(9)


" See Readme Previews
nmap gm :LivedownToggle<CR>

" Copy outside vim
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP

" Python LSP and highlight
let g:python_highlight_all = 1


let g:ale_linters = {
    \   'javascript': ['eslint'],
    \   'javascriptreact': ['eslint'],
    \   'python': ['flake8'],
    \}

let g:ale_sign_error = '>>'
let g:ale_fixers = {'javascript': ['prettier', 'eslint']}

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Package.json info mapping
lua << EOF
require('package-info').setup()
vim.api.nvim_set_keymap(
    "n",
    "<leader>ns",
    "<cmd>lua require('package-info').show()<cr>",
    { silent = true, noremap = true }
)

EOF

let g:bettercomments_language_aliases = { 'javascript': 'js' }

" Ignore errors
function Null(error, response) abort
endfunction

" See function definitions on hover
augroup hover
	autocmd!
	autocmd CursorHold * if !coc#float#has_float()
		\| call CocActionAsync('doHover', 'float', function('Null'))
		\| call CocActionAsync('highlight', function('Null'))
	\| endif
	autocmd CursorHoldI * if CocAction('ensureDocument')
		\|silent call CocActionAsync('showSignatureHelp')
	\| endif
augroup end
