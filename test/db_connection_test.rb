require 'test/unit'
require File.join(File.expand_path(File.dirname(__FILE__)), 'test_helper')
require 'db_connection'

class DBConnectionTest < Test::Unit::TestCase
  def setup
  end
  
  def test_the_connection
    assert_equal PGconn::CONNECTION_OK, DBBase.connection.conn.status
  end
end
