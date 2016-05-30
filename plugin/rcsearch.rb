module BioVim
  def self.rcsearch(seq)
    return nil unless seq.match(/\A[GATCN]+\z/i)
    revcomp = {
      "A" => "T",
      "G" => "C",
      "T" => "A",
      "C" => "G",
      "N" => "[ATGC]",
      }
    rcseq = seq.each_char.map{|a| revcomp[a.upcase]}.reverse.join
    '\c' + seq.upcase.gsub("N","[GATC]") + '\|' + rcseq
  end
end
