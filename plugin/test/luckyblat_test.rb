require 'test/unit'
require '../luckyblat.rb'      

class LuckyBlatTest < Test::Unit::TestCase
  def test_blat
    lb = LuckyBlat.new("agagcgggcgcgcctcttgcaagaaatgcagcga")
    assert_match /^chr/, lb.blat
  end

  def test_blat_url
    lb = LuckyBlat.new("agagcgggcgcgcctcttgcaagaaatgcagcga")
    assert_match /^https:\/\/genome-euro.ucsc.edu\/cgi-bin\/hgTracks\?position/, lb.blat(:url)
  end
end
