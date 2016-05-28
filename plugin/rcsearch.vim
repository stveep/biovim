exec expand("rubyfile <sfile>:p:h/rcsearch.rb")
function! Rcsearch(seq)
  ruby <<EOF
    seq = VIM::evaluate('a:seq')
    pattern = BioVim.rcsearch(seq)
    VIM.command("let pattern = \'#{pattern}\'")
EOF
  let @/ = pattern
  normal! n
endfunction
