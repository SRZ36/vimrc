"============================= neobundle  ===========================
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" originalrepos on github
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
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
NeoBundle 'bbatsov/rubocop'
NeoBundle 'alpaca-tc/vim-endwise'
NeoBundle 'alpaca-tc/alpaca_tags'

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
