scriptencoding utf-8
" {{{ General settings
" Taken from gentoo's vimrc
set nocompatible        " Use Vim defaults (much better!)
set bs=2                " Allow backspacing over everything in insert mode
set ai                  " Always set auto-indenting on
set history=50          " keep 50 lines of command history
set ruler               " Show the cursor position all the time
set encoding=utf-8 nobomb

set viminfo='20,\"500   " Keep a .viminfo file.

" Don't use Ex mode, use Q for formatting
map Q gq

" When displaying line numbers, don't use an annoyingly wide number column.
set numberwidth=3
" }}}

set nomodeline

" {{{ Filetype plugin settings
" Enable plugin-provided filetype settings, but only if the ftplugin
" directory exists (which it won't on livecds, for example).
if isdirectory(expand("$VIMRUNTIME/ftplugin"))
  filetype plugin on
endif
" }}}

" {{{ Autocommands
if has("autocmd")

augroup gentoo
  au!
  autocmd FileType crontab set backupcopy=yes
augroup END

endif " has("autocmd")
" }}}

" We don't want VIM to load their own built-in defaults, preferring ours here
" instead:
let g:skip_defaults_vim = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
set cursorline
set number
set lazyredraw
set background=dark

set showmatch
set incsearch
set hlsearch
set ignorecase smartcase

set title

set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

" Always enable status bar
set laststatus=2

set nostartofline
set foldenable
set foldmethod=indent
set foldlevelstart=8
set foldnestmax=8

" Scroll before reaching end of visible text
set scrolloff=5

" Autocomplete
set wildmenu
set wildmode=longest:full,full

set ttyfast

" Switch to last file
nnoremap <leader><leader> <c-^>

" Easier split moves
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" {{{ MAGIC TAB
" From Gary Bernhardt
function! InsertTabWrapper()
        let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
                return "\<tab>"
        else
                return "\<c-p>"
        endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>
" }}}

" {{{ Strip Whitespace
" Taken from ?
function! StripWhitespace()
        let save_cursor = getpos(".")
        let old_query = getreg('/')
        :%s/\s\+$//e
        call setpos('.', save_cursor)
        call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()
" }}}
"
" Default tab/spacing settings
set noexpandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
filetype indent on

if has("autocmd")

augroup configgroup
        autocmd!
        autocmd VimEnter * highlight clear SignColumn
        autocmd BufWritePre *.c,*.cc,*.cpp,*.py,*.js,*.ts,*.txt :%s/\s\+$//e
        autocmd FileType c,cpp setlocal ts=8 sts=8 sw=8
        autocmd FileType python setlocal textwidth=79
augroup END

endif " has("autocmd")

" {{{ Show Whitespace
" Shortcut to toggle display of whitespace
nmap <leader>op :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,space:• 
" }}}
"
" {{{ UltiSnips
let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetsDir = $HOME.'/plugged/vim-snippets/UltiSnips'
" }}}

" {{{ Plugins
" Update with :PlugUpdate
call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
call plug#end()
" }}}

" {{{ vimtex settings
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
" }}}
