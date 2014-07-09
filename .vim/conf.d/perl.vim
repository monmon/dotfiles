" http://perl-users.jp/articles/advent-calendar/2012/casual/13
augroup filetypedetect
    autocmd! BufNewFile,BufRead *.t setf perl
    autocmd! BufNewFile,BufRead *.psgi setf perl
    autocmd! BufNewFile,BufRead *.tt setf tt2html
augroup END

augroup template
    autocmd!
    autocmd BufNewFile *.pl 0r $HOME/.vim/template/perl-script.txt
    autocmd BufNewFile *.t  0r $HOME/.vim/template/perl-test.txt
    autocmd BufNewFile *.pm call s:pm_template()
augroup END

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

"====

iab pdump   use Data::Dump 'dump'; warn dump 
iab pyamp   use YAML; warn Dump 
iab pdumper use Data::Dumper; $Data::Dumper::Sortkeys=$Data::Dumper::Indent=$Data::Dumper::Terse=$Data::Dumper::Deparse=1;<CR>warn Dumper [ ];<Left><Left><Left>
iab pdie    use Data::Dumper; die Dumper 
iab phdump  $___dump = function(){ error_log(print_r(func_get_args(), true)); }; $___dump();<C-O>h 
