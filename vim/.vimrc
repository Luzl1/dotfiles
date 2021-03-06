set nocompatible        " get rid of strict vi compatibility!
filetype off

"***********************************************
"**** Autoreload config file
"***********************************************
augroup loadinitvim
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END



" ***********************************************
" * Plug
" ***********************************************
"
"************************************************
"*Autoinstall Vim-Plug
"************************************************
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
" call plug#begin('~/.local/share/nvim/plugged')
call plug#begin('~/.vim/plugged')

"* Core Plugins
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'tomtom/tcomment_vim'
Plug 'rking/ag.vim'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'wsdjeg/vim-fetch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'cyberkov/openhab-vim'
Plug 'vimwiki/vimwiki'

"* Python
" Plug 'klen/python-mode'
" Plug 'davidhalter/jedi-vim'


" * Colorschemes
Plug 'tomasr/molokai'
Plug 'jpo/vim-railscasts-theme'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'


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
set splitbelow   "more natutal splitting
set splitright   "more natural splitting

" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). This
" causes incorrect background rendering when using a color
" theme with a background color.
let &t_ut=''

let g:airline_powerline_fonts=1	"Make powerline symbols show
let g:airline#extensions#tabline#enabled=1 "Make tabline show up
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme='gruvbox'
" let g:airline_theme='onedark'
let g:netrw_liststyle=3


"VimWiki
let wiki = {}
let g:vimwiki_list = [{'path': '~/Nextcloud/documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
" let g:vimwiki_list = [wiki]
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'sh': 'sh'}
let g:vimwiki_folding='list'
let g:vimwiki_global_ext = 0


"Edit privileged file as normal user"
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute 'W:' | :q
command WQ :Wq




"*********************************************
"*       fzf+ripgrep
"*********************************************

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,.icons,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)




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

let mapleader="\<SPACE>"

map <leader>p :Files<CR>
nnoremap <leader>f :BLines<CR>
nnoremap <leader>g :Rg<CR>

"Faster shortcut for commentig. Requires tComment Plugin
map <leader>c <c-_><c-_>

"Shortcut for editing ~/.vimrc
nnoremap <leader>v :e ~/.vimrc<CR>

"Shortcut for undotree
nnoremap <leader>u :UndotreeToggle<CR>

"NerdTree
map <C-n> :NERDTreeToggle<CR>

" For switching between many opened file by using ctrl+l or ctrl+h
" nmap <leader>b :ls<CR>:buffer<space>
nmap <leader>b :Buffers<CR>

"Navigate splits with ctrl+j ctrl+k ctrl+h ctrl+l
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:onedark_terminal_italics = 1
syntax on
" colorscheme onedark
colorscheme gruvbox
" colorscheme railscasts
" let g:molokai_original = 1
" let g:rehash256 = 1
"
" Enable 24 bit color
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
" if (empty($TMUX))
"   if (has("nvim"))
"     "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"     let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"   endif
"   "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"   "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"   " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"   if (has("termguicolors"))
"     set termguicolors
"   endif
" endif
