let mapleader = " "
if !exists("g:os")
    if has("win64") || has("win32")
        let g:os = "Windows"
    else
        let g:os = split(system('uname -a'), ' ')[0]
    endif
endif


call plug#begin()

"vim enhancements
Plug 'ciaranm/securemodelines'
Plug 'editorconfig/editorconfig-vim'
Plug 'justinmk/vim-sneak' 
Plug 'tpope/vim-sleuth'

"GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'chriskempson/base16-vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"File system
Plug 'airblade/vim-rooter'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'rhysd/vim-clang-format'
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'alvan/vim-closetag'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
"Plug 'wikitopian/hardmode'

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'

call plug#end()

"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
end


" deal with colors
if !has('gui_running')
    set t_Co=256
endif

set termguicolors

colorscheme base16-gruvbox-dark-hard
"colorscheme base16-atelier-savanna
"colorscheme base16-atelier-sulphurpool-light

syntax on


" Plugin settings
let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction


" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

"have vim-rooter re-route to the root of git repos 
let g:rooter_patterns = ['.git']



" =============================================================================
" # Language Settings
" =============================================================================

" Javascript
let javaScript_fold=0

" Java
let java_ignore_javadoc=1

" Latex
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []

" rust
let g:rustfmt_autosave = 0
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" Completion
" Better display for messages
set cmdheight=1
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" =============================================================================
" # Editor settings
" =============================================================================
filetype plugin indent on
set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=2
set noshowmode
set hidden
set nowrap
set nojoinspaces
let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Settings needed for .lvimrc
set exrc
set secure

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

"Tab handeling
set expandtab tabstop=4 shiftwidth=4

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/


" =============================================================================
" # GUI settings
" =============================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set nofoldenable
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=500
set laststatus=2
set relativenumber " Relative line numbers
set number " Also show current absolute line
set nu rnu
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set colorcolumn=
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " don't give |ins-completion-menu| messages.

" Show hidden characters
set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•,space:.


" =============================================================================
" # LSP Support
" =============================================================================

lua << EOF

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  --buf_set_keymap('n', ',D', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',h', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',d', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',t', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',w', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',b', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',n', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local lsp = require('lsp-zero')

vim.lsp.set_log_level("debug")

lsp.preset('recommended')

lsp.set_preferences({
  manage_nvim_cmp = false
})

lsp.setup()

lsp.ensure_installed({
  'clangd',
  'rust_analyzer',
  'rnix',
  'jdtls',
})
  

lsp.on_attach(function(client, bufnr)
  local noremap = {buffer = bufnr, remap = false}
  local bind = vim.keymap.set

  --bind('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', noremap)
  --   --buf_set_keymap('n', ',D', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  bind('n', ',h', '<Cmd>lua vim.lsp.buf.definition()<CR>', noremap)
  bind('n', ',d', '<Cmd>lua vim.lsp.buf.hover()<CR>', noremap)
  bind('n', ',i', '<cmd>lua vim.lsp.buf.implementation()<CR>', noremap)
  bind('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', noremap)
  bind('n', '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', noremap)
  bind('n', ',t', '<cmd>lua vim.lsp.buf.rename()<CR>', noremap)
  bind('n', ',w', '<cmd>lua vim.lsp.buf.code_action()<CR>', noremap)
  bind('n', ',r', '<cmd>lua vim.lsp.buf.references()<CR>', noremap)
  bind('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', noremap)
  bind('n', ',b', '<cmd>lua vim.diagnostic.goto_prev()<CR>', noremap)
  bind('n', ',n', '<cmd>lua vim.diagnostic.goto_next()<CR>', noremap)
  bind('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', noremap)
  bind('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', noremap)
end)

vim.fn.setenv("CARGO_TARGET_DIR", "/tmp/nvim-rust-target"..os.getenv("PWD"))

EOF



" =============================================================================
" # Key Remappings
" =============================================================================

"leader + l to go to the last position before a cursor jump
nnoremap <leader>l <C-o>

"Editor file actions
noremap <silent> <leader><leader> :b#<CR>
"noremap <silent> <leader>w :w<CR>
"noremap <silent> <leader>q :q<CR>

noremap <silent> <leader>n :bnext<CR>
noremap <silent> <leader>t <c-^>
noremap <silent> <leader>b :bprev<CR>
noremap <silent> <leader>e :bd<CR>
noremap <silent> <Tab> g_

nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<CR>

" <leader>q shows stats
nnoremap <leader>. g<c-g>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

noremap <leader>( i import React from 'react'<CR>const XX = () => {<CR>return (<CR><CR>)<CR>}<CR><CR>export default XX;<ESC>
imap sout System.out.println("


"Unmap programmer dvorak keybinds when in normal mode for things like 3d
nmap [ 7
nmap { 5
nmap } 3
nmap ( 1
nmap = 9
nmap * 0
nmap ) 2
nmap + 4
nmap ] 6
nmap ! 8

"Disable arrow keys when in normal mode 
noremap <silent> <Right> :bnext<CR>
noremap <silent> <Left> :bprev<CR>
noremap <silent> <Down> :bw<CR>
nnoremap <silent> <Up> :Files<CR>


inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

"Use kk in addition to escape because its faster to type and jj to save too
imap <silent> kk <Esc>
imap <silent> jj <Esc>:w<CR>

"Fzf keybinds
nnoremap <silent> <leader>o <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>h <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <silent> <leader>s <cmd>lua require('telescope.builtin').live_grep()<CR>
"Prevent searches in files for looking for filenames
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"make sv reload the init.vim file
nnoremap <leader>rc :source $MYVIMRC<CR>


set undodir=~/.vimdid
set undofile


if g:os == "Linux"
  " X clipboard integration
  " p will paste clipboard into buffer
  " c will copy entire buffer into clipboard
  noremap <leader>p :read !xsel --clipboard --output<cr>
  noremap <leader>c :w !xsel -ib<cr><cr>
else
  if g:os == "Darwin"
    noremap <leader>p :read !pbpaste<cr>
    noremap <leader>c :w !pbcopy<cr><cr>
 
  endif
endif


" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>



" =============================================================================
" # Autocommands
" =============================================================================

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Jump to last edit position on opening file
if has("autocmd")
    " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
    au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
