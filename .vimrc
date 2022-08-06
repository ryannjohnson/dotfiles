set nocompatible

" Prevents tracking vim history, etc.
set viminfo=""

" Enables row and column numbers on the bottom of the screen
" while navigating the document.
set ruler

" Highlights matching text while typing a search query.
set incsearch

" Highlights all search pattern matches.
set hlsearch

" Soft wrap words instead of characters.
set wrap
set linebreak
set showbreak=..

" Artificially limits the width of the window so that soft
" wrapping isn't solely dependent on window width.
au BufRead,BufReadPost,BufNewFile *.fountain,*.md setlocal columns=80
au BufRead,BufReadPost,BufNewFile *.fountain,*.md autocmd VimResized * if (&columns > 80) | set columns=80 | endif

au BufRead,BufReadPost,BufNewFile *.fountain setlocal filetype=fountain
au BufRead,BufReadPost,BufNewFile *.md setlocal ai expandtab
