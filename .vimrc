" mapleaderは,に
let mapleader = ','

" viとの互換性をOFF
set nocompatible

" エンコーディング設定
set encoding=utf-8
" set fileencodings=iso-2022-jp,euc-jp,cp932,utf-8 " isoから順に試す
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
set nolist
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

set updatecount=50            " 50文字でswapファイル作成

syntax on

" 開いた時に前回閉じた時の行にカーソルを合わせる
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif



" ====================================================
" vundle settings
" ====================================================
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'vcscommand.vim'
Bundle 'octave.vim'
Bundle 'QuickBuf'
Bundle 'scratch'
"Bundle 'skk.vim-B'
Bundle 'sudo.vim'
Bundle 'The-NERD-tree'
Bundle 'neocomplcache'
Bundle 'Javascript-syntax-with-Ajax-Support'
Bundle 'Simple-Javascript-Indenter'

" non github repos
Bundle 'git://git.wincent.com/command-t.git'

 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..

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

" NERD_tree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
