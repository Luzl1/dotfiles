
" ~/init.vim

set nocompatible        " get rid of strict vi compatibility!
filetype off

"***********************************************
"**** Autoreload config file
"***********************************************
augroup loadinitvim
    au!
    autocmd bufwritepost init.vim source ~/.config/nvim/init.vim
augroup END



" ***********************************************
" * Plug
" ***********************************************

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')



"* Core Plugins
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'tomtom/tcomment_vim'
Plug 'rking/ag.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'JazzCore/ctrlp-cmatcher'
Plug 'nixprime/cpsm'
Plug 'sjl/gundo.vim'

"* Python
Plug 'klen/python-mode'
Plug 'davidhalter/jedi-vim'


" * Colorschemes
Plug 'tomasr/molokai'
Plug 'jpo/vim-railscasts-theme'
Plug 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call plug#end()            " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line




" **************************************
" * VARIABLES
" **************************************

filetype plugin indent on

set nu              	" line numbering on
set autoindent          " autoindent on
set noerrorbells        " bye bye bells :)
set modeline            " show what I'm doing
set showmode            " show the mode on the dedicated line (see above)
set nowrap          	" no wrapping!
set ignorecase          " search without regards to case
set backspace=indent,eol,start  " backspace over everything
set fileformats=unix,dos,mac    " open files from mac/dos
"set colorcolumn=80	" Draws a red line at 80 character limit
set exrc  	        " open local config files
set nojoinspaces        " don't add white space when I don't tell you to
set ruler           	" which line am I on?
set showmatch           " ensure Dyck language
set incsearch           " incremental searching
set nohlsearch          " meh
set bs=2                " fix backspacing in insert mode
set bg=light
set laststatus=2	" Always have statusbar showing
"set term=xterm-256color	" Make colors pretty!
" set termguicolors
set termencoding=utf-8	" ALlow for symbols
set encoding=utf-8	" moar symbols
set background=dark

let g:airline_powerline_fonts=1	"Make powerline symbols show
let g:airline#extensions#tabline#enabled=1 "Make tabline show up
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme='powerlineish'
let g:netrw_liststyle=3


" Temporary workaround for: https://github.com/neovim/neovim/issues/1716
if has("nvim")
  command! W w !sudo -n tee % > /dev/null || echo "Press <leader>w to authenticate and try again"
  map <leader>w :new<cr>:term sudo true<cr>
else
  command! W w !sudo tee % > /dev/null
end



"Edit privileged file as normal user"
"command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
" command W :w :term sudo tee % > /dev/null | :edit!
" command Wq :execute 'W:' | :q
" command WQ :Wq



" *********************************************************
" * CtrlP
" ********************************************************
set runtimepath^=~/.config/nvim/bundle/ctrlp.vim
" let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_max_depth=40
" let g:ctrlp_max_files=0
" let g:ctrlp_follow_symlinks=1

"Start CtrlP always in Mixed Mode
let g:ctrlp_cmd = 'CtrlPMixed'

"Use very fast pymatcher for file matching
" let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
" let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" let g:cpsm_match_empty_query = 0


" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
if executable('ag')
	let g:ctrlp_user_command = 'ag %s --files-with-matches -u -i --hidden -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
else
	" Fall back to using git ls-files if Ag is not available
	let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
	let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" Default to filename searches - so that appctrl will find application
" controller
let g:ctrlp_by_filename = 0

" Don't jump to already open window. This is annoying if you are maintaining
" several Tab workspaces and want to open two windows into the same file.
let g:ctrlp_switch_buffer = 0

" Set delay to prevent extra search
let g:ctrlp_lazy_update = 350

"*********************************************
"*      Python-mode settings
"*********************************************
" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"

" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0


"********************************************
"          jedi-vim
"*******************************************

" Use <leader>l to toggle display of whitespace
nmap <leader>l :set list!<CR>
" automatically change window's cwd to file's dir
set autochdir

" I'm prefer spaces to tabs
set tabstop=4
set shiftwidth=4
set expandtab

" more subtle popup colors
if has ('gui_running')
    highlight Pmenu guibg=#cccccc gui=bold
endif




" ****************************************
" Removing Trailing Whitespaces
" https://technotales.wordpress.com/2010/03/31/preserve-a-vim-function-that-keeps-your-state/
" ****************************************
function! Preserve(command)
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	execute a:command
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction


nmap <F5> :call Preserve("%s/\\s\\+$//e")<CR>



" *****************************************************
" * Keybindings
" *****************************************************

let mapleader=","


"Faster shortcut for commentig. Requires tComment Plugin
map <leader>c <c-_><c-_>

"Shortcut for editing ~/.vimrc
nnoremap <leader>v :e ~/.config/nvim/init.vim<CR>

"Shortcut for Gundo
nnoremap <leader>u :GundoToggle<CR>

"NerdTree
map <C-n> :NERDTreeToggle<CR>

" For switching between many opened file by using ctrl+l or ctrl+h
nmap <leader>b :ls<CR>:buffer<space>

syntax on
colorscheme molokai
" colorscheme railscasts
let g:molokai_original = 1
let g:rehash256 = 1
