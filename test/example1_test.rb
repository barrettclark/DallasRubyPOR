require 'test/unit'
require 'test_helper'
require 'example1'

class Example1Test < Test::Unit::TestCase
  def test_initialize
    example = Example1.new
    assert_equal 'Oh Hai', example.text
  end
end
