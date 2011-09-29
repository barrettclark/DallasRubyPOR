require 'test/unit'
require File.expand_path(File.dirname(__FILE__), 'zipcode')

class ZipCodeTest < Test::Unit::TestCase
  # This runs before each test method
  def setup
    @zipcode = ZipCode.new(
      :zip        => '00210',
      :city       => 'Portsmouth',
      :state      => 'NH',
      :latitude   => '43.005895',
      :longitude  => '-71.013202',
      :timezone   => '-5',
      :dst        => '1'
    )
  end
  
  # This runs after each test method
  def teardown
  end
  
  # You can have other supporting methods that the tests use
  def supporting_method
    puts 'This does nothing'
  end
  
  # Methods that begin with 'test_' are evaluated by Test/Unit as tests
  def test_initialize_hash
    assert_equal '00210', @zipcode.zip
  end
end
