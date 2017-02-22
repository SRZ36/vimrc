"============================= neobundle  ===========================
let s:use_dein = 1
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible
endif

if !isdirectory(s:dein_repo_dir)
  execute '!git clone git@github.com:Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

call dein#begin(s:dein_dir)

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimshell')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neocomplcache')
call dein#add('Shougo/neosnippet')
call dein#add('rhysd/accelerated-jk')
call dein#add('VimClojure')
call dein#add('honza/vim-snippets')
call dein#add('rhysd/clever-f.vim')
call dein#add('jpalardy/vim-slime')
call dein#add('scrooloose/syntastic')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('tpope/vim-fugitive')
call dein#add('kien/ctrlp.vim')
call dein#add('osyo-manga/vim-over')
call dein#add('Lokaltog/vim-powerline')
call dein#add('itchyny/landscape.vim')
call dein#add('bling/vim-airline')
call dein#add('bbatsov/rubocop')
call dein#add('alpaca-tc/vim-endwise')
call dein#add('alpaca-tc/alpaca_tags')

" colorschema
call dein#add('ujihisa/unite-colorscheme')
call dein#add('altercation/vim-colors-solarized')
call dein#add('jeffreyiacono/vim-colors-wombat')
call dein#add('mrkn/mrkn256.vim')
call dein#add('therubymug/vim-pyte')
call dein#add('vim-scripts/Zenburn')

"call dein#add(https://bitbucket.org/kovisoft/slimv')

call dein#end()

if dein#check_install()
  call dein#install()
endif

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
noremap <Space>. :<C-u>edit $MYVIMRC<Enter>
noremap <Space>s. :<C-u>source $MYVIMRC<Enter>

set nocursorline
autocmd InsertEnter,InsertLeave * set cursorline!

imap <c-j> <esc>
let mapleader=" "

"====================================================================

"======================== syntastic rubocop =========================
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_quiet_messages = {'level': 'warnings'}
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
