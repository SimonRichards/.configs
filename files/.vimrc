set nocompatible
filetype off " For vundle.

if !isdirectory(expand("~/.vim/bundle/vundle/.git"))
  !git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

set nolist

" Allows the bundle installation
Bundle 'gmarik/vundle'

" Better status line
Bundle 'Lokaltog/vim-powerline'

" Automatic lining up.
Bundle 'godlygeek/tabular'

" Tab-completion.
Bundle 'ervandew/supertab'

" Dependency of new SnipMate.
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'

" Clang based C/C++ Completion
Bundle "exclipy/clang_complete"

" New SnipMate.
Bundle 'garbas/vim-snipmate'
Bundle 'rbonvall/snipmate-snippets-bib'
Bundle 'honza/snipmate-snippets'

" Language syntaxes.
Bundle 'Nemo157/glsl.vim'
Bundle 'plasticboy/vim-markdown'
Bundle 'kchmck/vim-coffee-script'
Bundle 'vim-scripts/VimClojure'
Bundle 'PProvost/vim-ps1'

" Screen.vim
Bundle 'ervandew/screen'

" Color scheme.
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/Zenburn'

Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'mileszs/ack.vim'

filetype plugin indent on " Automatically detect file types
syntax enable " Syntax highlighting

set nocompatible " Turn off Vi compatibility.

set tabstop=2 expandtab shiftwidth=2                    " Set 2-spaces instead of tabs.
set number                                              " Set line numbers on.
set autoindent                                          " Use smart indentation.
set background=dark                                     " Who would use a light terminal?
set showmatch                                           " Show matching brackets.
set incsearch                                           " Incremental search.
set nowrap                                              " Turn off line wrapping.
set sidescroll=1                                        " Set how far to scroll when moving off the edge.
set list listchars=precedes:<,extends:>,tab:»\ ,trail:▴ " Show tabs, lines going off the edge and the end of lines.
set ruler                                               " Show current position in document at bottom right.
set scrolloff=5                                         " Scroll 5 lines from the top and bottom.
set sidescrolloff=10                                    " Scroll 30 characters from the edges.
set spell                                               " Spell checking on.
set undofile undodir=/tmp                               " Store persistent undo files in /tmp.
set textwidth=80                                        " Set maximum width to 80 characters.
set suffixes+=.aux,.blg,.bbl,.log                       " Lower priority for tab completion
set cursorline                                          " Highlight the current line
set nofoldenable                                        " Turn them off until I bother learning them
set thesaurus+=~/.vim/thesaurus/mthesaur.txt            " Use the thesaurus from http://www.gutenberg.org/ebooks/3202
set bs=indent,eol,start                                 " Needed on Windows
set mouse=                                              " Disable mouse in gvim
set laststatus=2                                        " Always show the status line
set wildmenu                                            " Show a menu when tab-completing

let g:tex_flavor = "latex"                              " Give latex higher priority over tex.

let g:SuperTabDefaultCompletionType = "context"         " Set SuperTab to try and determine completion type automatically.
let g:SuperTabMappingForward = '<nul>'
let g:SuperTabMappingBackward = '<s-nul>'

let g:snips_trigger_key='<c-space>'
silent! colorscheme solarized

au FileType markdown\|rst\|tex\|plaintex setlocal textwidth=80
au FileType java\|c\|c++\|glsl setlocal tabstop=4 shiftwidth=4
au FileType vhdl setlocal noexpandtab tabstop=8 shiftwidth=8

let mapleader = ","

map <leader>a= :Tabularize /=<CR>
map <leader>a: :Tabularize /:\zs<CR>
map <leader>a" :Tabularize /"<CR>
map <leader>p :set invpaste<CR>
map <Right> :bn!<CR>
map <Left> :bp!<CR>
map <leader>bd :bd<CR>
map <leader>e :e ~/.vimrc<CR>
map <C-Right> <C-w><Right>
map <C-Left> <C-w><Left>

" Have Vim jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

au BufWritePost vimrc source ~/.vimrc

map <F5> :call SaveAndMake()<CR>
imap <F5> <C-o>:call SaveAndMake()<CR>

vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

command Wq wq
command -bang Q q<bang>

func! SaveAndMake()
  exec "up"
  exec "make!"
endfunc

nmap <leader>e :e ~/.vimrc <cr>
nmap <left> :bp <cr>
nmap <right> :bn <cr>
nmap <F5> :wa<cr> :!./%<cr>
imap <F5> <Esc>:wa<cr> :!./%<cr>

set hidden
set nolist
set textwidth=0
set wrapmargin=0
:nnoremap <F2> :%s/\<<C-r><C-w>\>/

let g:clang_auto_select=1
let g:clang_complete_auto=0
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=0
let g:clang_snippets=1
let g:clang_snippets_engine="clang_complete"
let g:clang_conceal_snippets=1
let g:clang_exec="clang"
let g:clang_user_options=""
let g:clang_auto_user_options="path, .clang_complete"
let g:clang_use_library=1
let g:clang_library_path="/usr/lib"
let g:clang_sort_algo="priority"
let g:clang_complete_macros=1
let g:clang_complete_patterns=0
nnoremap <Leader>q :call g:ClangUpdateQuickFix()<CR>

let g:clic_filename="/home/simon/indices/devel/index.db"
nnoremap <Leader>r :call ClangGetReferences()<CR>
nnoremap <Leader>d :call ClangGetDeclarations()<CR>
nnoremap <Leader>s :call ClangGetSubclasses()<CR>
