module BioVim
  class << self
    attr_accessor :complements
  end

  @complements = {
      "A" => "T",
      "G" => "C",
      "T" => "A",
      "U" => "A",
      "C" => "G",
      "N" => "N",
      "\n" => "\n",
      " " => " ",
      }

  def self.reverse_complement(seq)
    return 0 unless seq.match(/\A[ gatcnGATCN\n]+\z/i)
    rc = seq.each_char.map{|a| complements[a.upcase]}.reverse.join
    if rc[0] == "\n"
      rc.lstrip! + "\n"
    else
      rc
    end
  end

  def self.rcsearch(seq)
    return 0 unless seq.match(/\A[GATCN]+\z/i)
    rcseq = BioVim.reverse_complement(seq)
    '\c' + seq.upcase.gsub("N","[UGATC]") + '\|' + rcseq.gsub("N","[UGATC]")
  end
end
