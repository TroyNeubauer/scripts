let mapleader = " "
if !exists("g:os")
    if has("win64") || has("win32")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname -a'), '\n', '', '')
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


"File system
Plug 'airblade/vim-rooter'
if g:os == "Windows"
    Plug 'c/ProgramData/chotolatey/bin/fzf'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
else
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
endif

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'alvan/vim-closetag'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

call plug#end()


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
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
function! LightlineFilename()
    return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction


" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()


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

" Quick-save
nmap <leader>w :w<CR>

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

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
" # Key Remappings
" =============================================================================

"H and L for beginning and end of line
map H ^
map L $

" Use K to show documentation in preview window.


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_global_extensions = ['coc-spell-checker', 'coc-json', 'coc-markdownlint', 'coc-yaml', 'coc-yank', 'coc-git', 'coc-clangd', 'coc-flutter', 'coc-html', 'coc-java', 'coc-rust-analyzer', 'coc-tailwindcss', 'coc-tsserver']

"All coc related actions stem from q
noremap q <Nop>

nmap qr <Plug>(coc-references)
nmap qt <Plug>(coc-rename)
nmap qf :call CocAction('format')<CR>
nmap qi <Plug>(coc-implementation)
nmap qh <Plug>(coc-definition)
nmap qs <Plug>(coc-fix-current)
nmap qw <Plug>(coc-codeaction-selected)
nmap qj :CocCommand workspace.showOutput<CR>

nmap qd :call <SID>show_documentation()<CR>

nmap <silent> qb <Plug>(coc-diagnostic-prev)
nmap <silent> qn <Plug>(coc-diagnostic-next)


"leader + l to go to the last position before a cursor jump
nnoremap <leader>l <C-o>

"Editor file actions
noremap <silent> <leader><leader> :b#<CR>
noremap <silent> <leader>w :w<CR>
noremap <silent> <leader>q :q<CR>

noremap <silent> <leader>n :bnext<CR>
noremap <silent> <leader>t <c-^>
noremap <silent> <leader>b :bprev<CR>
noremap <silent> <leader>e :bw<CR>

nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<CR>

" <leader>q shows stats
nnoremap <leader>. g<c-g>

"nnoremap <leader>z :call vimspector#Launch()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction



"Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


noremap <leader>( i import React from 'react'<CR>const XX = () => {<CR>return (<CR><CR>)<CR>}<CR><CR>export default XX;<ESC>
imap sout System.out.println("



"Unmap programmer dvorak keybinds when in normal mode for things like 3d
nmap & 1
nmap [ 2
nmap { 3
nmap } 4
nmap ( 5
nmap = 6
nmap * 7
nmap ) 8
nmap + 9


"Disable arrow keys when in normal mode 
noremap <silent> <Right> :bnext<CR>
noremap <silent> <Left> :bprev<CR>
noremap <silent> <Down> :bw<CR>
nnoremap <silent> <Up> :Files<CR>

nmap <leader>h :Buffers<CR>

inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>



"Use kk in addition to ecsape because its faster to type and jj to save too
imap <silent> kk <Esc>
imap <silent> jj <Esc>:w<CR>

"Fzf keybinds
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>s :Rg<CR>
"Prevent searches in files for looking for filenames
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)


"make sv reload the init.vim file
nnoremap <leader>rc :source $MYVIMRC<CR>


set undodir=~/.vimdid
set undofile



" X clipboard integration
" p will paste clipboard into buffer
" c will copy entire buffer into clipboard
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>


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
