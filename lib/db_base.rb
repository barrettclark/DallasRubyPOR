require File.join(File.expand_path(File.dirname(__FILE__)), 'db_connection')

class DBBase
  def self.connection
    @dbh ||= DBConnection.new
  end
end
