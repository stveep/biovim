require 'test/unit'
require '../rcsearch.rb'      
class RcsearchTest < Test::Unit::TestCase
  def test_smoke
    assert_equal "\\cAGTC\\|GACT", BioVim.rcsearch("AGTC")
  end
  def test_N
    assert_equal "\\c[GATC][GATC]G\\|C[ATGC][ATGC]", BioVim.rcsearch("NNG")
  end
  def test_nil_return
    assert_nil BioVim.rcsearch("NotDNA")
  end
  def test_lowercase_input
    assert_equal "\\cAGTC\\|GACT", BioVim.rcsearch("agtc")
  end

end
