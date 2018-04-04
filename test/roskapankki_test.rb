require "test_helper"

class RoskapankkiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Roskapankki::VERSION
  end

  def test_it_does_something_useful
    assert_equal "hello world", Roskapankki.hi
  end
end
