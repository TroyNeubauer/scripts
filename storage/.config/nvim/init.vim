let mapleader = " "
if !exists("g:os")
    if has("win64") || has("win32")
        let g:os = "Windows"
    else
        let g:os = split(system('uname -a'), ' ')[0]
    endif
endif


call plug#begin('~/.vim/plugged')

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

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

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

set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c



lua << END
local cmp = require'cmp'

local lspconfig = require'lspconfig'
cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- Tab immediately completes. C-n/C-p to select.
    ['<Tab>'] = cmp.mapping.confirm({ select = true })
  },
  sources = cmp.config.sources({
    -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  })
})

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  --nmap qt <Plug>(coc-rename)
  --nmap qf :call My_coc_format()<CR>
  --nmap qi <Plug>(coc-implementation)
  --nmap qh <Plug>(coc-definition)
  --nmap qs <Plug>(coc-fix-current)
  --nmap qw <Plug>(coc-codeaction-selected)
  --nmap qj :CocCommand workspace.showOutput<CR>
  --nmap <C-g> <Plug>(coc-codelens-action)
  --
  --" Use CTRL-S for selections ranges.
  --" Requires 'textDocument/selectionRange' support of language server.
  --nmap <silent> qc <Plug>(coc-range-select)
  --xmap <silent> qc <Plug>(coc-range-select)
  --
  --nmap qd :call <SID>show_documentation()<CR>
  --nmap <silent> qb <Plug>(coc-diagnostic-prev)
  --nmap <silent> qn <Plug>(coc-diagnostic-next)

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', ',h', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', ',d', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', ',i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', ',t', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', ',w', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', ',r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', ',b', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ',n', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "none"
    },
  })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      completion = {
	postfix = {
	  enable = false,
	},
      },
      procMacro = {
        enable = true
      },
    },
  },
  capabilities = capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
END

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

lua << END
require('telescope').setup {
    extensions = {
        fzf_writer = {
            minimum_grep_characters = 2,
            minimum_files_characters = 2,
        }
    }
}
END

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


nmap h <Nop>
nmap l <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

"Use kk in addition to escape because its faster to type and jj to save too
imap <silent> kk <Esc>
imap jj kk:w<CR>

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
