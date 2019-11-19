" Install vim-plug {{{
" If there is not plug.vim, install it and install plugins
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

" Plug load {{{
call plug#begin('~/.vim/plugged')
    " tree
    Plug 'scrooloose/nerdtree'
    " Comment
    Plug 'scrooloose/nerdcommenter'
    " julia plugins
    Plug 'JuliaEditorSupport/julia-vim'
    " LSP and complete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " tex
    Plug 'lervag/vimtex'
    " vim-indent-guides
    Plug 'nathanaelkane/vim-indent-guides'
    " BioSyntax
    Plug 'bioSyntax/bioSyntax-vim'
    " statusline
    Plug 'itchyny/lightline.vim'
    " markdown
    Plug 'plasticboy/vim-markdown'
    " custom plugs
    if filereadable($HOME . "/.vim/plugs.vim")
        source ~/.vim/plugs.vim
    endif
call plug#end()
" }}}

" Misc config {{{

" filetype
filetype indent plugin on

" line number config
set number
set relativenumber

" syntax highlight
syntax on

" confirm when quit
set confirm

" indent config{
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent
" }

" leader
let mapleader=","
let maplocalleader=";"

" tab skip the brackets {{{
inoremap <silent> <Tab> <C-R>=TabSkip()<CR>

function! TabSkip()
    let char = getline('.')[col('.') - 1]
    if char == '}' || char == ')' || char == ']' || char == ';' || char == "'" || char == '`' || char == '"'
        return "\<Right>"
    else
        return "\<Tab>"
    endif
endf
" }}}

" hlsearch
set hlsearch
nnoremap <silent> <leader>n :nohlsearch<CR>

" showmatch
set showmatch

" novisualbell
set novisualbell

" showcmd
set showcmd

" encoding
set encoding=utf-8

" shell
set shell=/bin/zsh

" split
set splitbelow
set splitright

" julia version
let g:default_julia_version = '1.1'

" quickfix toggle
nnoremap <silent> <leader>tq :call quickfixtoggle#ToggleQuickfixList()<CR>

" remove tariling blanks
nnoremap <silent> <leader>tb :%s/[ \t]+$//<CR>

" indent guides
nnoremap <silent> <leader>it :IndentGuidesToggle<CR>

" }}}

" NERDTree config {{{
let NERDTreeShowHidden = 1
nnoremap <silent> <leader>tt :NERDTreeToggle<CR>
" }}}

" Tex config {{{
let g:tex_flavor='latex'
let g:vimtex_fold_enabled = 1
" }}}

" Comment config{{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" }}}

" Markdown config{{{
" fold
let g:vim_markdown_folding_disabled = 1

" latex extension
let g:vim_markdown_math = 1

" yaml extension for jekyll
let g:vim_markdown_frontmatter = 1

let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]
" }}}

" Coc config {{{
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <silent> <leader>l :CocList<CR>
nmap <silent> <leader>[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>d <plug>(coc-definition)
nmap <leader>rn <Plug>(coc-rename)
vmap <silent> <leader>f <Plug>(coc-format-selected)
nmap <silent> <leader>f <Plug>(coc-format)
" }}}

" Lightline config {{{
set laststatus=2

function! LightlineGitStatus() abort
    let status = get(b:, 'coc_git_status', '')
    " return blame
    return winwidth(0) > 120 ? status : ''
endfunction

function! LightlineReadonly()
      return &readonly && &filetype !~# '\v(help|vimfiler|unite)' ? 'RO' : ''
endfunction

function! LightlineFilename()
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    let modified = &modified ? '*' : ''
    return filename . modified
endfunction

let g:lightline = {
    \ 'colorscheme' : 'one',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'filename', 'readonly'] ],
    \   'right' : [
    \     [ 'gitstatus'],
    \     [ 'filetype', 'fileformat', 'fileencoding', 'spell',
    \       'lineinfo', 'percent' ],
    \   ],
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'gitstatus' : 'LightlineGitStatus',
    \   'readonly' : 'LightlineReadonly',
    \   'filename' : 'LightlineFilename',
    \ },
    \ }
" }}}

" custom config {{{
if filereadable($HOME . "/.vim/config.vim")
    source ~/.vim/config.vim
endif
" }}}

" vim:tw=76:tw=4:sw=4:et:fdm=marker
