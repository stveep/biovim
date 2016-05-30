module BioVim
  def self.rcsearch(seq)
    return 0 unless seq.match(/\A[GATCN]+\z/i)
    revcomp = {
      "A" => "T",
      "G" => "C",
      "T" => "A",
      "U" => "A",
      "C" => "G",
      "N" => "[UATGC]",
      }
    rcseq = seq.each_char.map{|a| revcomp[a.upcase]}.reverse.join
    '\c' + seq.upcase.gsub("N","[UGATC]") + '\|' + rcseq
  end
end
