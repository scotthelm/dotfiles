set nocompatible              " be iMproved, required
filetype off                  " required

"-------------------------------------------------------------------------------
" Vundle
"-------------------------------------------------------------------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlp.vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ervandew/supertab'
Plugin 'chriskempson/base16-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'w0rp/ale'
Plugin 'fatih/vim-go'
Plugin 'vim-rspec'
Plugin 'jgdavey/vim-blockle'
call vundle#end()            " required
filetype plugin indent on    " required

"-------------------------------------------------------------------------------
" basics
"-------------------------------------------------------------------------------
set nobackup
set nowritebackup
set noswapfile
set number
syntax on
set laststatus=2
set noerrorbells visualbell t_vb=
set clipboard=unnamed   " use system clipboard by default!
set hlsearch
set backspace=indent,eol,start

" Spell check and automatic wrapping at 72 columns for commit messages          
autocmd Filetype gitcommit setlocal spell textwidth=72 

" Spellcheck Markdown Files                                                   
autocmd BufRead,BufNewFile *.md setlocal spell

" make .etl ruby files
au BufNewFile,BufRead *.etl setlocal ft=ruby
"-------------------------------------------------------------------------------
" basics
"-------------------------------------------------------------------------------
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'

set statusline+=%#warningmsg#
set statusline+=%*

" ------------------------------------------------------------------------------
"  ale (linter) settings
" ------------------------------------------------------------------------------
let g:ale_sign_error = '⁉️'
let g:ale_sign_warning = '🔶'

" ------------------------------------------------------------------------------
"  Tabs/Spaces
" ------------------------------------------------------------------------------
set expandtab
set ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype go setlocal ts=4 sts=4 sw=4 noexpandtab

" ------------------------------------------------------------------------------
"  Background Colors
" ------------------------------------------------------------------------------
set background=dark
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
execute "set colorcolumn=" . join(range(81,335), ',')

" ------------------------------------------------------------------------------
"  cursor shape
" ------------------------------------------------------------------------------
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"


" ------------------------------------------------------------------------------
" custom crap
" ------------------------------------------------------------------------------
let mapleader = ","
" Quickly hide search highlighting
nmap <silent> <leader>n :silent :nohlsearch<CR>

" ------------------------------------------------------------------------------
" Window navigation
" ------------------------------------------------------------------------------
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>


" ------------------------------------------------------------------------------
" Ctrl P
" ------------------------------------------------------------------------------
map <Leader>p :CtrlP<CR>
" let g:ctrlp_custom_ignore = 'tmp$\|tags$\|\.ds_store$|\.swp|git$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git$|vendor$|tmp$|node_modules$)',
  \ 'file': '\v\.(exe\|so\|dll\|.ds_store\|tags$)$',
  \ }
let g:ctrlp_dotfiles = 0

nmap <C-\><C-\> gc

" ------------------------------------------------------------------------------
" Autocommands
" ------------------------------------------------------------------------------
autocmd BufEnter Guardfile,.pryrc setlocal filetype=ruby


" ------------------------------------------------------------------------------
" Remaps
" ------------------------------------------------------------------------------
nnoremap <leader>j "*p0y$d$[<Esc>i[]()<Esc>hpT/yt)0p<Esc>

" ------------------------------------------------------------------------------
" vim-javascript
" ------------------------------------------------------------------------------
let g:jsx_ext_required = 0

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

" silent !mkdir -p ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile
"
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>


augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

  " :GoRename
  autocmd FileType go nmap <Leader>n <Plug>(go-def-split)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction


" ----------------------------------------------------------------------------
" Interleave Util
function! Interleave()
    " retrieve last selected area position and size
    let start = line(".")
    execute "normal! gvo\<esc>"
    let end = line(".")
    let [start, end] = sort([start, end], "n")
    let size = (end - start + 1) / 2
    " and interleave!
    for i in range(size - 1)
        execute (start + size + i). 'm' .(start + 2 * i)
    endfor
endfunction

" Select your two contiguous, same-sized blocks, and use it to Interleave ;)
vnoremap <leader>v <esc>:call Interleave()<CR>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
