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

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
nnoremap <space> za
vnoremap <space> zf

let g:syntastic_aggregate_errors = 1

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

func! MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunc

augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
