set nocompatible
set viminfo=""    " Prevents tracking vim history, etc.
set ruler         " Shows cursor position.
set incsearch     " Highlights matching text while typing a search query.
set hlsearch      " Highlights all search pattern matches.
set modelines=0   " Disable modelines as a security precaution
set nomodeline

" Soft wrap words instead of characters.
set wrap
set linebreak
set showbreak=..

" Display extra whitespace.
set list listchars=tab:»·,nbsp:·

" Artificially limits the width of the window so that soft
" wrapping isn't solely dependent on window width.
"au BufRead,BufReadPost,BufNewFile *.fountain,*.md setlocal columns=80
"au BufRead,BufReadPost,BufNewFile *.fountain,*.md autocmd VimResized * if (&columns > 80) | setlocal columns=80 | endif

au BufRead,BufReadPost,BufNewFile *.fountain setlocal filetype=fountain
au BufRead,BufReadPost,BufNewFile *.md setlocal filetype=markdown ai expandtab
