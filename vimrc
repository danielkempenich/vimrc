
" Setup pathogen
call pathogen#infect()
call pathogen#helptags()

" Tabs highlighting
autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax * SpaceHi
au FileType help NoSpaceHi

" NERDTree
noremap <C-e> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Airline
set laststatus=2
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

syn on
set hls
set nu
set ru
set scrolloff=4
noremap <C-n> :bnext<CR>
noremap <C-p> :bprev<CR>
noremap <C-d> :bd<CR>
noremap <C-w> :w!<CR>
if has("gui_running")
    colorscheme desert
    let do_syntax_sel_menu = 1|runtime! synmenu.vim|aunmenu &Syntax.&Show\ filetypes\ in\ menu
    set guifont=Fira\ Mono\ 12,Liberation\ Mono\ 12
else
    colorscheme blue
endif

" Default 4 spaces, no tabs, the way it was meant to be
set et
set tabstop=4
set shiftwidth=4
set encoding=utf-8

" Searching
set hlsearch "Highlight search results"
set ignorecase "Ignore case while searching"
set smartcase " ...unless search includes mixed case"


" Finally check for tabs
function DK_settabs()
    if version >= 700
        " Count how many lines start with tab. Compare to the number of
        " lines starting with four spaces. If tabs win, then set options.
        " also if more lines start with three spaces then a non-space than 4 spaces than a word, just deal with it
        " in this case it's better to be consistently wrong.
        set cin
        if len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^\\t"')) > len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^    "'))
            verbose set noexpandtab tabstop=4 shiftwidth=4
        elseif len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^   [^ ]"')) > len(filter(getbufline(winbufnr(0), 1, "$"), 'v:val =~ "^    [^ ]"'))
            verbose set expandtab tabstop=3 shiftwidth=3
        else
            verbose set expandtab tabstop=4 shiftwidth=4
        endif
    else
        " Early vim version just pick the most commonly used method
        set cin
        verbose set expandtab tabstop=4 shiftwidth=4
    endif
endfunction
autocmd BufReadPost * call DK_settabs()

" Set cindentation
set cindent
set cinoptions=(s,us

" Allow us to use backspace in indent mode
set backspace=indent,eol,start

