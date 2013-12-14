:set path=.,lib
:nmap <Space> :wa<CR>:call system("git-slides next")<CR>:e!<CR>
:nmap <Backspace> :wa<CR>:call system("git-slides prev")<CR>:e!<CR>
:nmap <leader>sl :wa<CR>:call system("git-slides next")<CR>:e!<CR>
:nmap <leader>sh :wa<CR>:call system("git-slides prev")<CR>:e!<CR>
:nmap <leader>sL :call system("git-slides next -f")<CR>:e!<CR>
:nmap <leader>sH :call system("git-slides prev -f")<CR>:e!<CR>
:nmap <leader>ss :wa<CR>:call system("git-slides save")<CR>:e!<CR>
:nmap <leader>sb :wa<CR>:call system("git-slides insert-before")<CR>:e!<CR>
:nmap <leader>sa :wa<CR>:call system("git-slides insert-after")<CR>:e!<CR>
:nmap <leader>st :wa<CR>:call system("git-slides transform")<CR>:e!<CR>
:nmap <leader>sd :wa<CR>:call system("git-slides delete")<CR>:e!<CR>
:nmap <leader>rp :wa<CR>:!perl %<CR>
