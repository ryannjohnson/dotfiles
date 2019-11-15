set nocompatible
set viminfo=""
set ruler
set incsearch
set hlsearch

au BufReadPost,BufNewFile *.md setlocal ai tw=80 nojoinspaces
