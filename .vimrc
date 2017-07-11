" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

""" ========================================================
""" For Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'jlanzarotta/bufexplorer'
Plugin 'YiyiLee/vim-idutils'
Plugin 'YiyiLee/winmanager'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/taglist.vim'
Plugin 'Valloric/YouCompleteMe'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
""" Vundle end
""" ========================================================

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=700		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is changed by steven
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ls=2		" view current file name
set ts=4
set tags=tags

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Set font according to system
" if MySys() == "mac"
"  set gfn=Menlo:h14
"  set shell=/bin/bash
"elseif MySys() == "windows"
"  set gfn=Bitstream\ Vera\ Sans\ Mono:h10
"elseif MySys() == "linux"
  set gfn=Monospace\ 10
  set shell=/bin/bash
"endif

if has("gui_running")
  set guioptions-=T
  set t_Co=256
  set background=dark
  colorscheme peaksea
  set nonu
else
  colorscheme zellner
  set background=dark

  set nonu
endif

set encoding=utf-8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is changed by steven - end
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" change tab enters as spaces
set expandtab

" To control the number of space characters that will be inserted when the tab
" key is pressed
set tabstop=2
" To change the number of space characters inserted for indentation
set shiftwidth=2

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

map <f5> :call g:IDSearchCurrentWord()<CR> 
map <C-x> :FufFile<CR>

"cscope quick fix"
set cscopequickfix=s-,c-,d-,i-,t-,e-,g-

"mini buffer explorer"
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1   
let g:miniBufExplMapCTabSwitchBufs = 1   
let g:miniBufExplModSelTarget = 1  
let g:miniBufExplMoreThanOne=0 
let g:miniBufExplMaxSize = 20
"let g:miniBufExplVSplit = 20

" Maximize the window after entering it, be sure to keep the quickfix window
" at the specified height.
au WinEnter * call MaximizeAndResizeQuickfix(5)

" Maximize current window and set the quickfix window to the specified height.
function MaximizeAndResizeQuickfix(quickfixHeight)
  " Redraw after executing the function.
  set lazyredraw
  " Ignore WinEnter events for now.
  set ei=WinEnter
  " Maximize current window.
  wincmd _
  " If the current window is the quickfix window
  if (getbufvar(winbufnr(winnr()), "&buftype") == "quickfix")
    " Maximize previous window, and resize the quickfix window to the
    " specified height.
    wincmd p
    resize
    wincmd p
    exe "resize " . a:quickfixHeight
  else
    " Current window isn't the quickfix window, loop over all windows to
    " find it (if it exists...)
    let i = 1
    let currBufNr = winbufnr(i)
    while (currBufNr != -1)
      " If the buffer in window i is the quickfix buffer.
      if (getbufvar(currBufNr, "&buftype") == "quickfix")
        " Go to the quickfix window, set height to quickfixHeight, and jump to the previous
        " window.
        exe i . "wincmd w"
        exe "resize " . a:quickfixHeight
        wincmd p
        break
      endif
      let i = i + 1
      let currBufNr = winbufnr(i)
    endwhile
  endif
  set ei-=WinEnter
  set nolazyredraw
endfunction

" Remap ,m to make and open error window if there are any errors. If there
" weren't any errors, the current window is maximized.
map <silent> ,m :mak<CR><CR>:cw<CR>:call MaximizeIfNotQuickfix()<CR>

" Maximizes the current window if it is not the quickfix window.
function MaximizeIfNotQuickfix()
  if (getbufvar(winbufnr(winnr()), "&buftype") != "quickfix")
    wincmd _
  endif
endfunction

" Taglist
let Tlist_Show_One_File = 1     " Displaying tags for only one file~
let Tlist_Exist_OnlyWindow = 1  "  if you are the last, kill yourself
let Tlist_Sort_Type = "name" " sort by order or name
let Tlist_GainFocus_On_ToggleOpen = 0 " Jump to taglist window on open.
let Tlist_Enable_Fold_Column = 0 " Don't Show the fold indicator column in the taglist window.
let Tlist_WinWidth = 40

" Nerd tree
let g:NERDTree_title="[NERDTree]"
let g:winManagerWindowLayout="NERDTree|TagList"  

function! NERDTree_Start()  
  exec 'NERDTree'  
endfunction  

function! NERDTree_IsValid()  
  return 1  
endfunction  

" let NERDTreeQuitOnOpen = 0
" let g:NERDTreeDirArrows=0

let Tlist_Show_One_File = 1
let Tlist_Enable_Fold_Column = 0

nmap wm :WMToggle<CR>  

" show line number
set nu

" call BufExplorer 
noremap <silent> <F4> :BufExplorer<CR>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" read the custom settings for every folder
if filereadable(".vim.custom")
  so .vim.custom
endif

let g:ackprg="gid_with_col.py"
nnoremap <silent> <Leader>g :Ack<CR>

" read tags file from current folder
"let cwd = getcwd()
"let cwd.='/tags'
"" echo cwd
"let &tags=cwd

" Ctrl + \ : Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" resize split window key
noremap <silent> <F6> <C-W>+ <CR>

" enable c++11 syntax
set syntax=cpp11

" command-t
let g:CommandTMaxFiles=500000
set wildignore=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg,*.git,*.gitignore

" YCM
let g:ycm_confirm_extra_conf = 0
map <C-k> :YcmCompleter GoToImprecise<CR>
