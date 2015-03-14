" Base settings {{{
colorscheme delek
set encoding=utf-8
set nocompatible
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
"set foldmethod=syntax

set hlsearch
set ignorecase
set incsearch

set number
set nowrap
set noswapfile
set modeline

set t_Co=256

syntax on

nnoremap <Leader>r :source ~/.vimrc<CR>
" }}}
" NeoBundle {{{
if has('vim_starting')
  filetype plugin off
  filetype indent off
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {
\  'build': {
\    'mac': 'make -f make_mac.mak'
\  },
\}
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'kana/vim-submode'
NeoBundle 'alpaca-tc/alpaca_powertabline'
NeoBundle 'Lokaltog/powerline.git', { 'rtp' : 'powerline/bindings/vim' }
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vimtaku/hl_matchit.vim.git'
NeoBundle 'elzr/vim-json'
NeoBundleLazy 'alpaca-tc/alpaca_tags', {
      \    'depends': ['Shougo/vimproc'],
      \    'autoload' : {
      \       'commands' : [
      \          { 'name' : 'AlpacaTagsBundle', 'complete': 'customlist,alpaca_tags#complete_source' },
      \          { 'name' : 'AlpacaTagsUpdate', 'complete': 'customlist,alpaca_tags#complete_source' },
      \          'AlpacaTagsSet', 'AlpacaTagsCleanCache', 'AlpacaTagsEnable', 'AlpacaTagsDisable', 'AlpacaTagsKillProcess', 'AlpacaTagsProcessStatus',
      \       ],
      \    }
      \ }
call neobundle#end()

NeoBundleCheck

filetype plugin on
filetype indent on
" }}}
" unite.vim {{{
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1

nnoremap [unite] <Nop>
nmap <Leader>u [unite]

nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]u :<C-u>Unite file file_mru buffer directory directory/new file/new<CR>
" }}}
" submode.vim {{{
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
" }}}
" powerline {{{
set laststatus=2
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:Powerline_symbols = 'fancy'
let g:Powerline_colorscheme = 'solarized'
set noshowmode
" }}}
" {{{
if !exists('loaded_matchit')
  " matchitを有効化
  runtime macros/matchit.vim
endif
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'Title'
let g:hl_matchit_allow_ft = 'ruby'

let g:alpaca_tags#config = {
      \    '_' : '-R --sort=yes',
      \    'ruby': '--languages=+Ruby',
      \ }
augroup AlpacaTags
  autocmd!
  if exists(':AlpacaTags')
    autocmd BufWritePost Gemfile AlpacaTagsBundle
    autocmd BufEnter * AlpacaTagsSet
    autocmd BufWritePost * AlpacaTagsUpdate
  endif
augroup END
" }}}
" for Ruby {{{
autocmd BufNewFile,BufRead *.cap set filetype=ruby
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead Capfile set filetype=ruby
"autocmd BufNewFile,BufRead *.rb set tags+=${HOME}/ruby.tags
" }}}

"
autocmd FileType * setlocal formatoptions-=ro

if filereadable($HOME . '.vimrc.local')
  source $HOME/.vimrc.local
endif
