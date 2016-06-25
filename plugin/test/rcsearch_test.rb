require 'test/unit'
require '../rcsearch.rb'      
class RcsearchTest < Test::Unit::TestCase
  def test_reverse_complement
    assert_equal "ATGC", BioVim.reverse_complement("GCAT")
  end

  def test_smoke
    assert_equal "\\cAGTC\\|GACT", BioVim.rcsearch("AGTC")
  end
  def test_N
    assert_equal "\\c[UGATC][UGATC]G\\|C[UATGC][UATGC]", BioVim.rcsearch("NNG")
  end

  def test_nil_return
    assert_equal 0, BioVim.rcsearch("NotDNA")
  end

  def test_lowercase_input
    assert_equal "\\cAGTC\\|GACT", BioVim.rcsearch("agtc")
  end

end
