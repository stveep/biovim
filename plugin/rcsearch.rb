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
      "N" => "[UATGC]",
      }

  def self.reverse_complement(seq)
    seq.each_char.map{|a| complements[a.upcase]}.reverse.join
  end

  def self.rcsearch(seq)
    return 0 unless seq.match(/\A[GATCN]+\z/i)
    rcseq = BioVim.reverse_complement(seq)
    '\c' + seq.upcase.gsub("N","[UGATC]") + '\|' + rcseq
  end
end
