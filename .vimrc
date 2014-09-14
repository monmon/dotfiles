" mapleaderは,に
let mapleader = ','

colorscheme koehler

" viとの互換性をOFF
set nocompatible

" エンコーディング設定
set encoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp " isoから順に試す
set ambiwidth=double                             " 全角矢印などの表示幅を全角に

" 検索機能の設定
set smartcase  " 大文字があれば区別、小文字だけなら区別しない
set hlsearch   " 結果をハイライト
set wrapscan   " 末尾まで検索したら先頭へループ

" インデントの共通設定
" set autoindent    " 新しい行を開始した時にインデントを現在と同じにする
set tabstop=4     " TAB
set smartindent   " 新しい行を作ったときに高度な自動インデント
set softtabstop=4 " とじ括弧の時にindentが戻る
set shiftwidth=4  " 自動インデント時の空白の数
set expandtab     " タブの代わりに空白

" 行番号などの表示回り
set number
set noruler        " カーソルが何行目何列目に置かれているかを表示しない
set showmatch      " とじ括弧入力時に対応する括弧を表示
set wrap
set title
set showcmd        " コマンドをステータスラインに表示
set cmdheight=2
set laststatus=2   " 常にステータスラインを表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}
set wildmenu       " コマンドラインの補完候補を表示
set nocursorline

set backspace=indent,eol,start " backspaceキーの挙動
set scrolloff=5                " 最低でもカーソルから5行表示

set nobackup
set history=1000

set nrformats=octal,hex,alpha " ctrl-a,ctrl-xでalpha,8,16を認識

set swapfile
set directory=~/.vimtmp
set updatecount=50            " 50文字でswapファイル作成

" http://vim-users.jp/2009/07/hack40/
scriptencoding utf-8
augroup highlightDoubleByteSpace
  autocmd!
  autocmd VimEnter,Colorscheme * highlight DoubleByteSpace term=underline ctermbg=red guibg=red
  autocmd VimEnter,WinEnter,BufRead * match DoubleByteSpace /^\t\+\|　\|\s\+$/
augroup END

syntax on

" 開いた時に前回閉じた時の行にカーソルを合わせる
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif



" ====================================================
" vundle settings
" ====================================================
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

set runtimepath+=~/.vim/
runtime! conf.d/*.vim

" My Plugins here:
"
" original repos on github
Plugin 'tpope/vim-fugitive'

Plugin 'Lokaltog/vim-easymotion'

Plugin 'thinca/vim-quickrun'

"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'The-NERD-tree'

Plugin 'tyru/open-browser.vim'
Plugin 'superbrothers/vim-quickrun-markdown-gfm'

"Plugin 'vcscommand.vim'
"Plugin 'octave.vim'
"Plugin 'QuickBuf'
"Plugin 'scratch'
""Plugin 'skk.vim-B'
"Plugin 'sudo.vim'
"Plugin 'neocomplcache'
"Plugin 'Javascript-syntax-with-Ajax-Support'
"Plugin 'Simple-Javascript-Indenter'

" non github repos
"Plugin 'git://git.wincent.com/command-t.git'

 " Brief help
 " :PluginList          - list configured bundles
 " :PluginInstall(!)    - install(update) bundles
 " :PluginSearch(!) foo - search(or refresh cache first) for foo
 " :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Plugin command are not allowed..

 call vundle#end()            " required
 filetype plugin indent on    " required

" ==========================================================

filetype indent on
filetype plugin indent on
filetype plugin on


"======================= Key Mappings ======================
nnoremap <Space>w :<C-u>update<CR>
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>

" help
nnoremap <expr> <Space>h ':<C-u>help ' . expand('<cword>') . '<CR>'

" line feed
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" window
" C-Wなしで移動
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" Auto complete
" 矩形選択した後にそれぞれの記号で囲む
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
