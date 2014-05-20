"============================= neobundle  ===========================
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" originalrepos on github
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \   }, 
  \ }
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'
NeoBundle 'rhysd/accelerated-jk'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'itchyny/landscape.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'alpaca-tc/vim-endwise'
NeoBundle 'alpaca-tc/alpaca_tags'
NeoBundle 'scrooloose/nerdtree.git'
NeoBundle 'tpope/vim-surround.git'
NeoBundle 'open-browser.vim'

" Ruby
NeoBundle 'bbatsov/rubocop'
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'vim-scripts/ruby-matchit'

" colorschema
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'vim-scripts/Zenburn'

""NeoBundle 'https://bitbucket.org/kovisoft/slimv'

filetype plugin indent on     " required!
filetype indent on
"====================================================================


"============================ 基本設定 ==============================
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set nocompatible
set backspace=start,eol,indent
set whichwrap=b,s,[,],<,>,~
set mouse=
syntax on
set number
set wildmenu wildmode=list:full
set noswapfile
set wrap
"set nowrap
set expandtab
set ts=2
set autoindent
set shiftwidth=2
set showmatch
set matchtime=2
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/
highlight CursorLine ctermfg=none       ctermbg=darkgray cterm=none
highlight MatchParen ctermfg=none       ctermbg=darkgray 
highlight Comment    ctermfg=DarkGreen  ctermbg=NONE 
highlight Directory  ctermfg=DarkGreen  ctermbg=NONE 
colorscheme default
nnoremap <C-h>       :<C-u>help<Space>
nnoremap <C-h><C-h>  :<C-u>help<Space><C-r><C-w><Enter>
nnorema <Space>. :<C-u>edit $MYVIMRC<Enter>
nnorema <Space>s. :<C-u>source $MYVIMRC<Enter>

set nocursorline
autocmd InsertEnter,InsertLeave * set cursorline!

imap <c-j> <esc>
let mapleader=" "

nnorema <Space>. :<C-u>edit $MYVIMRC<Enter>
nnorema <Space>s. :<C-u>source $MYVIMRC<Enter>
"====================================================================

"======================== syntastic rubocop =========================
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_quiet_messages = {'level': 'warnings'}
"====================================================================

"======================== neocomplcache =============================
let g:neocomplcache_enable_at_startup = 1
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
let g:neocomplcache_max_list = 20
let g:neocomplcache_enable_smart_case = 1
"====================================================================

"======================== neosnippet ================================
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
"====================================================================

"======================== Rsense ====================================
let g:neocomplcache#sources#rsense#home_directory = '/opt/rsense-0.3'
"====================================================================

"====================================================================
  nmap <silent> <C-e>      :NERDTreeToggle<CR>
  vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
  omap <silent> <C-e>      :NERDTreeToggle<CR>
  imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
  cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=0
let g:NERDTreeMouseMode=2

" キー割り当て: ファイルタイプからスクリプトをRで実行
if has("autocmd")
  command! CommandRun call s:CommandRun()
  map R :CommandRun<CR>
  function! s:CommandRun()
    :w
    if &filetype == "php"
      :!php %
    elseif &filetype == "perl"
      :!perl %
    elseif &filetype == "ruby"
      :!ruby %
    elseif &filetype == "python"
      :!python %
    endif
  endfunction
endif
"====================================================================

"========================= AlpacaTags ===============================
augroup AlpacaTags
	autocmd!
	if exists(':Tags')
		autocmd BufWritePost Gemfile TagsBundle
		autocmd BufEnter * TagsSet
		" 毎回保存と同時更新する場合はコメントを外す
		" " autocmd BufWritePost * TagsUpdate
	endif
augroup END
"====================================================================

"========================= vim-over =================================
" over.vimの起動
nnoremap <silent> <Leader>m :OverCommandLine<CR>

" カーソル下の単語をハイライト付きで置換
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>

" コピーした文字列をハイライト付きで置換
nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!','g')<CR>!!gI<Left><Left><Left>
"====================================================================

"======================== open-browser ==============================
" カーソル下のURLをブラウザで開く
nmap <Leader>o <Plug>(openbrowser-open)
vmap <Leader>o <Plug>(openbrowser-open)
" ググる
nnoremap <Leader>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>
"====================================================================

"========================  高速でjkを使う ===========================
let g:accelerated_jk_acceleration_table = [10,5,3]
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
"====================================================================


"================== 階層色付け(vim-indent-guides) ====================
let g:indent_guides_enable_on_vim_startup = 1

" 自動カラー無効
let g:indent_guides_auto_colors = 0

" 奇数列は意図的に背景色と同じにする
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=green

let g:indent_guides_start_level = 1

let g:indent_guides_guide_size = 1
"=====================================================================


"====================== vimの戦闘力を計測 ===========================
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
  \        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
"====================================================================
