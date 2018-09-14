
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

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
" call plug#begin('~/.local/share/nvim/plugged')
call plug#begin('~/.config/nvim/plugged')

"* Core Plugins
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'tomtom/tcomment_vim'
Plug 'rking/ag.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'JazzCore/ctrlp-cmatcher'
Plug 'nixprime/cpsm', { 'do': 'env PY3=OFF ./install.sh' }
Plug 'sjl/gundo.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'wsdjeg/vim-fetch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'


"* Python
" Plug 'klen/python-mode'
" Plug 'davidhalter/jedi-vim'


" * Colorschemes
Plug 'tomasr/molokai'
Plug 'jpo/vim-railscasts-theme'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'

" All of your Plugins must be added before the following line
call plug#end()            " required

" Brief help
" :PluginList       - lists configured plugins
" :PlugInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" :PlugUpgrade    - upgrade Vimplug
"




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
" let g:airline_theme='powerlineish'
let g:airline_theme='onedark'
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
" let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

" let g:cpsm_match_empty_query = 0

let g:ctrlp_user_command = 'fd --type f --color=never "" %s'

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
" if executable('ag')
" 	let g:ctrlp_user_command = 'ag %s --files-with-matches -u -i --hidden -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
"
" 	" ag is fast enough that CtrlP doesn't need to cache
" 	let g:ctrlp_use_caching = 0
" else
" 	" Fall back to using git ls-files if Ag is not available
" 	let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
" 	let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
" endif

" Default to filename searches - so that appctrl will find application
" controller
let g:ctrlp_by_filename = 0

" Don't jump to already open window. This is annoying if you are maintaining
" several Tab workspaces and want to open two windows into the same file.
let g:ctrlp_switch_buffer = 0

" Set delay to prevent extra search
let g:ctrlp_lazy_update = 350
let g:ctrlp_use_caching = 0



"*********************************************
"*       fzf+ripgrep
"*********************************************

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,.icons,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)



" "*********************************************
" "*      Python-mode settings
" "*********************************************
" " Python-mode
" " Activate rope
" " Keys:
" " K             Show python docs
" " <Ctrl-Space>  Rope autocomplete
" " <Ctrl-c>g     Rope goto definition
" " <Ctrl-c>d     Rope show documentation
" " <Ctrl-c>f     Rope find occurrences
" " <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" " [[            Jump on previous class or function (normal, visual, operator modes)
" " ]]            Jump on next class or function (normal, visual, operator modes)
" " [M            Jump on previous class or method (normal, visual, operator modes)
" " ]M            Jump on next class or method (normal, visual, operator modes)
" let g:pymode_rope = 0
"
" " Documentation
" let g:pymode_doc = 1
" let g:pymode_doc_key = 'K'
"
" "Linting
" let g:pymode_lint = 1
" let g:pymode_lint_checker = "pyflakes,pep8"
"
" " Auto check on save
" let g:pymode_lint_write = 1
"
" " Support virtualenv
" let g:pymode_virtualenv = 1
"
" " Enable breakpoints plugin
" let g:pymode_breakpoint = 1
" let g:pymode_breakpoint_bind = '<leader>b'
"
" " syntax highlighting
" let g:pymode_syntax = 1
" let g:pymode_syntax_all = 1
" let g:pymode_syntax_indent_errors = g:pymode_syntax_all
" let g:pymode_syntax_space_errors = g:pymode_syntax_all
"
" " Don't autofold code
" let g:pymode_folding = 0
"
"
" "********************************************
" "          jedi-vim
" "*******************************************
"
" " Use <leader>l to toggle display of whitespace
" nmap <leader>l :set list!<CR>
" " automatically change window's cwd to file's dir
" set autochdir
"
" " I'm prefer spaces to tabs
" set tabstop=4
" set shiftwidth=4
" set expandtab
"
" " more subtle popup colors
" if has ('gui_running')
"     highlight Pmenu guibg=#cccccc gui=bold
" endif




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

let g:onedark_terminal_italics = 1
syntax on
colorscheme onedark
" colorscheme railscasts
" let g:molokai_original = 1
" let g:rehash256 = 1
"
" Enable 24 bit color
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
