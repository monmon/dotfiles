" mapleaderは,に
let mapleader = ','

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
set directory=~/
set updatecount=50            " 50文字でswapファイル作成

" http://d.hatena.ne.jp/potappo2/20061107/1162862536
set list
set listchars=tab:>_,trail:_,nbsp:%,extends:>,precedes:<

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
Bundle 'thinca/vim-quickrun'

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

" ===================  perl  ===============================
" http://perl-users.jp/articles/advent-calendar/2012/casual/13
augroup filetypedetect
    autocmd! BufNewFile,BufRead *.t setf perl
    autocmd! BufNewFile,BufRead *.psgi setf perl
    autocmd! BufNewFile,BufRead *.tt setf tt2html
augroup END

autocmd BufNewFile *.pl 0r $HOME/.vim/template/perl-script.txt
autocmd BufNewFile *.t  0r $HOME/.vim/template/perl-test.txt

function! s:pm_template()
    let path = substitute(expand('%'), '.*lib/', '', 'g')
    let path = substitute(path, '[\\/]', '::', 'g')
    let path = substitute(path, '\.pm$', '', 'g')

    call append(0, 'package ' . path . ';')
    call append(1, 'use strict;')
    call append(2, 'use warnings;')
    call append(3, 'use utf8;')
    call append(4, '')
    call append(5, '')
    call append(6, '')
    call append(7, '1;')
    call cursor(6, 0)
    " echomsg path
endfunction
autocmd BufNewFile *.pm call s:pm_template()

function! s:get_package_name()
    let mx = '^\s*package\s\+\([^ ;]\+\)'
    for line in getline(1, 5)
        if line =~ mx
        return substitute(matchstr(line, mx), mx, '\1', '')
        endif
    endfor
    return ""
endfunction

function! s:check_package_name()
    let path = substitute(expand('%:p'), '\\', '/', 'g')
    let name = substitute(s:get_package_name(), '::', '/', 'g') . '.pm'
    if path[-len(name):] != name
        echohl WarningMsg
        echomsg "ぱっけーじめいと、ほぞんされているぱすが、ちがうきがします！"
        echomsg "ちゃんとなおしてください＞＜"
        echohl None
    endif
endfunction

au! BufWritePost *.pm call s:check_package_name()

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

" quickrun
nmap <Leader>r <plug>(quickrun)
set splitright "新しいウィンドウを右に開く
