set nocompatible
set viminfo=""
set ruler
set incsearch
set hlsearch

au BufReadPost,BufNewFile,BufRead *.md setlocal ai tw=80 nojoinspaces
