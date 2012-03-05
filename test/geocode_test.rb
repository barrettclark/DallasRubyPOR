# require 'test/unit'
# require File.join(File.expand_path(File.dirname(__FILE__)), 'test_helper')
# require 'geocode'
# require 'logging'
# require 'webmock/test_unit'
# include Logging

# class GeocodeTest < Test::Unit::TestCase
#   def setup
#     filename = File.join(File.expand_path(File.dirname(__FILE__)), 'geocode.xml')
#     stub_request(:get, 'http://www.stands4.com/services/v1/zip.aspx?tokenid=tk1902&zip=90210').
#       to_return(:body => File.new(filename),
#                 :status => 200,
#                 :headers => {'Content-Type' => 'application/xml'})
#   end

#   def test_reverse_geocode
#     geocode = Geocode.reverse_geocode('90210')
#     assert_equal "Beverly Hills, CA", geocode['location']
#   end

#   def test_reverse_geocode_not_found
#     assert_raises WebMock::NetConnectNotAllowedError do
# 	  geocode = Geocode.reverse_geocode('00000')
#     end
#   end
# end
