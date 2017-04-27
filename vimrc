execute pathogen#infect()

syntax enable
filetype plugin on
filetype indent on
colorscheme solarized

set paste
set autoread
" set wildmenu
set wildignore=*.o,*~,*.pyc
set ruler
set expandtab
set smarttab
set number
set ruler
set textwidth=80
set shiftwidth=4
set tabstop=4
set ai "Auto indent"
set incsearch
set background=dark
set backupdir=~/tmp
set ignorecase
set smartcase
hi colorcolumn ctermbg=246

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
nnoremap <space> za
vnoremap <space> zf

let g:syntastic_aggregate_errors = 1

let g:syntastic_python_checkers = ['flake8', 'pylint']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite * :call DeleteTrailingWS()

augroup vimrc_autocmds
  autocmd BufEnter *.py highlight OverLength ctermbg=red guibg=#592929
  autocmd BufEnter *.py match OverLength /\%79v.*/
  autocmd BufEnter *.sh highlight OverLength ctermbg=red guibg=#592929
  autocmd BufEnter *.sh match OverLength /\%150v.*/
augroup END

augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

set backupdir^=~/tmp,/tmp

function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

autocmd Filetype go setlocal ts=8 sw=8 noexpandtab
au BufWritePost *.go :silent !gofmt -w %
