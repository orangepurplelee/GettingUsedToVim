" $HOME/.config/nvim/init.vim
" $HOME/.vimrc

" vim-plug : vim plugins                 {{{
""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
    call plug#begin('~/.nvim/vim-plug')
else
    call plug#begin('~/.vim/vim-plug')
endif

call plug#end()
"  }}}

" basic setup                                {{{
""""""""""""""""""""""""""""""""""""""""""""""""

" This may or may not be needed
" set t_Co=256
set termguicolors

" map ; to <localmapleader>
" let maplocalleader=';'
" map ;; to ;
" nnoremap ;; ;


" show line numbers
set number
set relativenumber

" enable syntax highlight
syntax on

" set the size of undo buffer
set history=100

" hide mouse cursor during typing
set mousehide

" minimal number of screen lines to keep above and below the cursor
set scrolloff=2

" enable filetype detection,
" plus loading ftplugin.vim (or ftplugin/any_name.vim)
" and indent.vim (or indent/any_name.vim)
filetype plugin indent on

set fileformats=unix,dos

" Status Lines -> use airline or lightline
" set laststatus=2
" if has("statusline")
"  set statusline=%<%f\ %h%m%r%=[%{\"\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"\\"}:%y]%k\ %-14.(%l,%c/%L%)
"  set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%y%k\ %-14.(%l,%c/%L%)
" endif

" set visualbell
" turn off warning bell and warning blink
set noerrorbells visualbell t_vb=

" }}}

" basic key bindings                        {{{
"""""""""""""""""""""""""""""""""""""""""""""""
" map jk to <ESC>
inoremap jk <ESC>

" map , to <leader> key 
let mapleader=','

" key bindings for windows navigation
" can be commented out if using vim-tmux-navigator
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" H for moving to the first column, L for moving to the last column
" nnoremap H 0
" nnoremap L $

" key binding for capitalizing text
inoremap <C-u> <esc>moviwU`oa
nnoremap <C-u> moviwU`o

" key bindings for swithching buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" match trailing spaces as Error
" nnoremap <leader>w :match Error /\v +$/<cr>
" nnoremap <leader>W :match none<cr>

" resizing window size
nnoremap + <C-w>+
nnoremap - <C-w>-
if has('mac')
    if has('nvim')
	nnoremap ± <C-w>>
	nnoremap – <C-w><
    else
	nnoremap ± <C-w>>
	nnoremap – <C-w><
    endif
else
    if has('nvim')
        nnoremap <M-+> <C-w>>
        nnoremap <M--> <C-w><
    else
        nnoremap + <C-w>>
        nnoremap - <C-w><
    endif
endif

" save
nnoremap <C-s><C-s> :w<CR>
inoremap <C-s><C-s> <ESC>:w<CR>

" copy & paste
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>p o<ESC>"+p
nnoremap <leader>P O<ESC>"+P

" move lines
if has('mac')
    if has('nvim')
        nnoremap ∂ :m .+1<CR>==
        nnoremap ¨ :m .-2<CR>==
        vnoremap ∂ :m '>+1<CR>gv=gv
        vnoremap ¨ :m '<-2<CR>gv=gv
    else
        nnoremap ∂ :m .+1<CR>==
        nnoremap ¨ :m .-2<CR>==
        vnoremap ∂ :m '>+1<CR>gv=gv
        vnoremap ¨ :m '<-2<CR>gv=gv
    endif
else
    if has('nvim')
        nnoremap <M-d> :m .+1<CR>==
        nnoremap <M-u> :m .-2<CR>==
        vnoremap <M-d> :m '>+1<CR>gv=gv
        vnoremap <M-u> :m '<-2<CR>gv=gv
    else
        nnoremap d :m .+1<CR>==
        nnoremap u :m .-2<CR>==
        vnoremap d :m '>+1<CR>gv=gv
        vnoremap u :m '<-2<CR>gv=gv
    endif
endif

" toggle fold
nnoremap <Space><Space> za

" move the cursor to the last column in insert mode
inoremap <C-f> <Esc>A

" quickfix windows toggle key binding
nnoremap <leader>q :call QuickFixToggleC()<cr>

function! QuickFixToggleC()
    for l:i in range(1, winnr('$'))
        let l:bnum = winbufnr(l:i)
        if getbufvar(bnum, '&buftype') ==? 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfunction

" toggle cursorcolumn/cursorline
nnoremap <Space>cc :call ToggleCursorColumn()<CR>
nnoremap <Space>cl :call ToggleCursorColumn()<CR>
function! ToggleCursorColumn()
  if &cursorcolumn == 1
    set cursorcolumn!
    set cursorline!
    echo 'cursorcolumn/cursorline disabled'
  else
    set cursorcolumn
    set cursorline
    echo 'cursorcolumn/cursorline enabled'
  endif
endfunction
" }}}

" encoding                                   {{{
" """"""""""""""""""""""""""""""""""""""""""""""
" default encoding : utf-8
set enc=utf-8
" set encoding=utf-8
scriptencoding utf-8
set fencs=utf-8,latin1
" set fileencodings=utf-8,latin1
set nobomb

" }}}

" vimrc & vimscript settings                 {{{
" """"""""""""""""""""""""""""""""""""""""""""""
" Vimscript foldmethod
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" key binding and sourcing for opening vimrc file
if has('win32')
    if has('nvim')
        nnoremap <leader>ev :e ~/AppData/Local/nvim/init.vim<cr>
        nnoremap <leader>sv :source ~/AppData/Local/nvim/init.vim<cr>
    else
        nnoremap <leader>ev :e ~/_vimrc<cr>
        nnoremap <leader>sv :source ~/_vimrc<cr>
    endif
else
    if has('nvim')
        nnoremap <leader>ev :e ~/.config/nvim/init.vim<cr>
        nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
    else
        nnoremap <leader>ev :e ~/.vimrc<cr>
        nnoremap <leader>sv :source ~/.vimrc<cr>
    endif
endif
" }}}

" search related setup                       {{{
" """"""""""""""""""""""""""""""""""""""""""""""
" search key mapping for search to use
" very magical regular expression
" nnoremap / :set hlsearch<cr>/
nnoremap / :set hlsearch<CR>/\v
onoremap / /\v
vnoremap / /\v
nnoremap ? :set hlsearch<CR>?\v
onoremap ? ?\v
vnoremap ? ?\v

" enable incsearch
set incsearch

" Ignore case when searching
set ignorecase

" Be smart when searching
set smartcase

" hlsearch key mappings
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohlsearch' : ':set hlsearch')."\n"
"  }}}

" indentation, Tab                           {{{
" """"""""""""""""""""""""""""""""""""""""""""""
" enable auto indentation
" set autoindent

" enable cindent
" set cindent

" enable smartindent
set smartindent

" backspace over indent in insert mode
set backspace=indent

" set indentation width
set shiftwidth=4

" set tab width
set tabstop=4

" set softtabstop
set softtabstop=4

" enable shiftround
set shiftround

" substitute tap to sapces
set expandtab
" }}}
