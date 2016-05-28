module BioVim
  def rcsearch(seq)
    revcomp = {
      "A" => "T",
      "G" => "C",
      "T" => "A",
      "C" => "G",
      "N" => "[ATGC]",
      }
    rcseq = seq.each_char.map{|a| revcomp[a.upcase]}.reverse.join
    '\c' + seq.gsub("N","[GATC]") + '\|' + rcseq
  end
end
