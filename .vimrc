" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

set nu
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif
"设置编码自动识别
"set fileencodings=utf-8,cp936,big5,euc-jp,euc-kr,latin1,ucs-bom
set fileencodings=utf-8,gbk
set ambiwidth=double

" taglist 源代码查找
 let Tlist_Show_One_File=1 "不同时显示多个文件的 tag ，只显示当前文件的
 let Tlist_Exit_OnlyWindow=1 "taglist窗口是最后一个时, 退出vim

let g:Tlist_Show_One_File=1   " only show tags for current window
let g:Tlist_Enable_Fold_Column=0    " don't waste space to display the column
let Tlist_File_Fold_Auto_Close=1 "让当前不被编辑的文件的方法列表自动折叠起来
let Tlist_Use_Right_Window=0 "把taglist窗口放在屏幕的左侧，1在右侧 
let Tlist_Auto_Open=1 "启动vim 自动打开TagList
let Tlist_Show_Menu=1 "显示taglist菜单
let Tlist_WinWidth = 25  "taglist窗口宽度
nmap <F3> :TlistToggle<CR>:<BS>
imap <F3> <Esc>:TlistToggle<CR>:<BS>i

"winManager  文件浏览
let g:winManagerWidth = 20 "设置WinManager宽度, 默认25
 "let g:winManagerWindowLayout='FileExplorer|TagList'
 let g:winManagerWindowLayout='FileExplorer|BufExplorer'
 nmap wm :WMToggle<cr>
 "进入vim 自动打开 WinManager
 let g:AutoOpenWinManager = 0

 syntax enable
 syntax on
 filetype plugin indent on
 set completeopt=longest,menu

 "启动鼠标
 set mouse=a
 
" 按F<F5>时在一个新的buffer中打开c\h文件,
" " 这样在写程序的时候就可以不假思索地在c/h文件间
nnoremap <silent:> <F5> :A<CR>


set cindent
set sw=4

set tabstop=4 "设定tab宽度为4个字符
set shiftwidth=4 "设定自动缩进为4个字符
set expandtab  "用space替代 tab的输入
set nobackup
set noswapfile

:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i

function ClosePair(char)
	  if getline('.')[col('.') - 1] == a:char
		        return "\<Right>"
	  else
			    return a:char
	  endif
endfunction

nnoremap <silent> <F4> :Grep<CR>
"''''''''''''''''''''''''''''''''''''"
set cpt=.,w,b,i "代码补全查找范围"
set completeopt=longest,menu  "提示菜单后输入字母实现即时的过滤和匹配"
""""""""""""""""""""""""""""""""""""""""
" set g:ctags_command for toolbar
let g:ctags_command='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'


"vim 自动补全 Python代码
""autocmd FileType python set complete+=k~/.vim/tools/pydictionplugin on
let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'"defalut g:pydiction_menu_height == 15"let g:pydiction_menu_height = 20
autocmd FileType python setlocal et | setlocal sta | setlocal sw=4



"新建.c,.h,.sh,.java.sh文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py,*.lua exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	"如果文件类型为.sh文件 
	if &filetype == 'sh'
		call setline(1,"\#!/bin/bash") 
		call append(line("."), "\#########################################################################") 
		call append(line(".")+1, "\# File Name: ".expand("%")) 
		call append(line(".")+2, "\# Author: Sam") 
		call append(line(".")+3, "\# mail: samyunwei@163.com") 
		call append(line(".")+4, "\# Created Time: ".strftime("%c")) 
		call append(line(".")+5, "\#########################################################################") 
		call append(line(".")+6, "") 
    elseif &filetype == 'python'
		call setline(1,"\#!/usr/bin/env python") 
		call append(line("."), "# -*- coding: UTF-8 -*-")
		call append(line(".")+1, "\# File Name: ".expand("%")) 
		call append(line(".")+2, "\# Author: Sam") 
		call append(line(".")+3, "\# mail: samyunwei@163.com") 
		call append(line(".")+4, "\# Created Time: ".strftime("%c")) 
		call append(line(".")+5, "\#########################################################################") 
		call append(line(".")+6, "") 
    elseif &filetype == 'lua'
		call setline(1, "\#!/usr/bin/env lua")
        call append(line("."), "--\# File Name: ".expand("%")) 
        call append(line(".")+1, "--\# Author: Sam") 
        call append(line(".")+2, "--\# mail: samyunwei@163.com") 
        call append(line(".")+3, "--\# Created Time: ".strftime("%c")) 
        call append(line(".")+4, "--\#########################################################################") 
        call append(line(".")+5, "") 
	else 
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: Sam") 
		call append(line(".")+2, "	> Mail: samyunwei@163.com ") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
	if &filetype == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
	if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%"))
        call append(line(".")+7,"")
	endif
	"新建文件后，自动定位到文件末尾
	autocmd BufNewFile * normal G
endfunc 

func CompileCC()
    exec "make"
    echo "just complie"
endfunc

func CompileJava()
    exec "!javac %"
    echo "just compile"
endfunc

func RunPython()
    exec "!python %"
endfunc

func RunLua()
    exec "!lua %"
endfunc

func RunShell()
    exec "!chmod a+x %"
    exec "!./%"
endfunc

""定义函数AutoRun，自动运行 
func AutoRun() 
    exec "w"
	if &filetype == 'sh'
        exec "call RunShell()"
    elseif &filetype == 'python'
        exec "call RunPython()"
    elseif &filetype == 'lua'
        exec "call RunLua()"
    elseif &filetype == 'cpp'
        exec "cal CompileCC()"
    elseif &filetype == 'c'
        exec "cal CompileCC()"
    elseif &filetype == 'java'
        exec "cal CompileJava()"
	endif
endfunc 

map <F6> :call AutoRun()<CR>
