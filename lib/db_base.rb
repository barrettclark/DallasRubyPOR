require File.join(File.expand_path(File.dirname(__FILE__)), 'db_connection')

class DBBase
  require 'logging'
  include Logging
  def self.connection
    @dbh ||= DBConnection.new
  end
end
