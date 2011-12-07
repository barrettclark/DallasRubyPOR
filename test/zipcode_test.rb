require 'test/unit'
require File.join(File.expand_path(File.dirname(__FILE__)), 'test_helper')
require 'zipcode'
require 'logging'
include Logging

class ZipCodeTest < Test::Unit::TestCase
  # This runs before each test method
  def setup
    # nuke the database table
    DBBase.connection.exec('TRUNCATE TABLE zipcode')
    
    # create a fresh zipcode object
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
    logger.warn 'This does nothing'
  end
  
  # Methods that begin with 'test_' are evaluated by Test/Unit as tests
  def test_initialize_hash
    assert_equal '00210', @zipcode.zip
    assert_equal -5, @zipcode.timezone
    assert_equal 43.005895, @zipcode.latitude
    assert_in_delta(43.0059, @zipcode.latitude, 0.001)
  end
  
  def test_timezone_name
    assert_equal 'US/Eastern', @zipcode.timezone_name
    assert_match(/east/i, @zipcode.timezone_name)
  end
  
  def test_dst_question_mark
    assert @zipcode.dst?

    zip = ZipCode.new(:dst => '0')
    assert_equal false, zip.dst?
    assert_nil zip.zip
    assert_not_nil zip.latitude
  end
  
  def test_create
    @zipcode.create
    count = DBBase.connection.exec('SELECT COUNT(*) FROM zipcode')
    assert_equal 1, count.getvalue(0,0).to_i
  end
  
  def test_create_class_method
    zipcode = ZipCode.create(
      :zip        => '33558',
      :city       => "Land O' Lakes",
      :state      => 'FL',
      :latitude   => '28.157704',
      :longitude  => '-82.514615',
      :timezone   => '-5',
      :dst        => '1'
    )
    count = DBBase.connection.exec('SELECT COUNT(*) FROM zipcode')
    assert_equal 1, count.getvalue(0,0).to_i
    assert_equal '33558', zipcode.zip
  end
  
  def test_find_class_method
    @zipcode.create
    found_zipcode = ZipCode.find(@zipcode.zip)
    assert_equal @zipcode.zip, found_zipcode.zip
  end
end
