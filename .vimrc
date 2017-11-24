execute pathogen#infect()
filetype on
filetype plugin on
filetype plugin indent on

" allow vim to use modelines such as : #vim:syntax=python
set modeline
set modelines=5

set guioptions=
" Colorscheme options
colorscheme molokai      " scheme
let g:molokai_original = 1  " molokai tweaks
let g:rehash256 = 1
"
set encoding=utf-8
set guifont=Monospace\ 8
set nocompatible        " Usar los valores por defecto de VIM en lugar de VI
set nobackup            " No genera backups
set incsearch           " nos sitúa automáticamente en la cadena que estemos buscandobu
set ruler
set ai                  " autoindenta
"set cin                 " activar la indentación de C

set showcmd             " muestra los comandos parcialmente
set ignorecase          " ignorecase matching
set smartcase
set showmatch           " autorelaciona los ( )'s, { }'s, etc...
set nu                  " numeracion de filas
syntax on               " colorea la sintaxis
set backspace=2         " permitir los backspace encima de cualquier cosa en el modo edición

set ls=2                " barra de estado siempre visible

" set scrolloff=999       " cursors en el medio de la pantalla

set expandtab
set sw=4
set softtabstop=4
set tabstop=4

set textwidth=80
set smarttab
set cursorline cursorcolumn


" Python dict
if has("autocmd")
    autocmd FileType python set complete+=k/usr/share/vim/vimfiles/dict/pydiction-0.5/pydiction isk+=.,(
endif

set mouse=a            " activa el mouse en consola
"" Abreviaturas
ab WQ wq
ab wQ wq
ab Wq wq
iab _hora =strftime("%H:%M")
iab _fecha =strftime("%d/%m/%y %H:%M:%S")
iab _finfoe =strftime("Escrito el día %d/%m/%y a las %H:%M:%S")%
iab _finfoi =strftime("Wrote in %m/%d/%y at %H:%M:%S")
let fs=0

" Tabs
nnoremap <tab> :tabnext<CR>
nnoremap <S-tab> :tabprevious<CR>
nnoremap <C-c> :tabclose<CR>

" Learn to properly use h, j, k, l:
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Switch between relative and static line numbers
" https://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set nu
  else
    set rnu
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

" Removes trailing spaces
function TrimWhiteSpace()
: %s/\s*$//
: ''
:endfunction
nnoremap <C-s> :call TrimWhiteSpace()<cr>

autocmd FileWritePre   * :call TrimWhiteSpace()
autocmd FileAppendPre  * :call TrimWhiteSpace()
autocmd FilterWritePre * :call TrimWhiteSpace()
autocmd BufWritePre    * :call TrimWhiteSpace()

map tt :TagbarToggle<cr>

" persistent undo - remember to create this dir
set undodir=$HOME/.vim/undo
set undolevels=5000
set undofile

" Ubuntu buggy logipat plugin
let g:loaded_logipat = 1
