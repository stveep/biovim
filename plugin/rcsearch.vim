function! Rcsearch(seq)
  ruby << EOF
    seq = VIM::evaluate('a:seq')
    revcomp = {
      "A" => "T",
      "G" => "C",
      "T" => "A",
      "C" => "G",
      "N" => "N",
      }
    rcseq = seq.each_char.map{|a| revcomp[a.upcase]}.reverse.join
    pattern = '\c' + seq + '\|' + rcseq
    VIM.command("let pattern = \'#{pattern}\'")
EOF
  let @/ = pattern
  normal! n
endfunction

