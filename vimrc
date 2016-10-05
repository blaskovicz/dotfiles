"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
let mapleader = "," " change VIM leader
"match OverLength /\%81v.\+/
set tabstop=2
set smarttab
set shiftwidth=2
set expandtab
set ignorecase
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
"set list
vnoremap > >gv
vnoremap < <gv
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
execute pathogen#infect()
syntax enable
au BufNewFile,BufRead *.tt set filetype=html
au BufRead,BufNewFile *.cf set ft=cf3
au BufRead,BufNewFile *.cfg set ft=nagios
filetype plugin indent on

let g:go_fmt_command = "$GOPATH/bin/goimports"

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_perl_checkers = ['perl', 'perlcritic']
"let g:syntastic_enable_perl_checker = 1
" / end syntastic settings
