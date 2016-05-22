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
    fwdseq = seq
    rcseq = seq.each_char.map{|a| revcomp[a.upcase]}.reverse.join
    VIM.command('/\c'+seq+'\|'+rcseq)
EOF
endfunction

