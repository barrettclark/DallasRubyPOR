class DBConnection
  require 'yaml'
  require 'logging'
  include Logging
  attr_reader :conn

  def initialize
    config = database_config
    @conn = PGconn.open(
      :dbname => config['dbname'],
      :user   => config['user'],
      :port   => config['port']
    )
  rescue
    logger.error "Unable to connect to the #{ENV['SCRIPT_ENV']} database"
  end
  
  def exec(sql)
    logger.debug(sql)
    @conn.exec(sql)
  end

  private

  def database_config
    logger.debug "Attempting to connect to the #{ENV['SCRIPT_ENV']} database"
    filename = File.join(File.expand_path(File.dirname(__FILE__)), '..', 'config', 'database.yml')
    config = YAML.load(File.read(filename))
    config[ENV['SCRIPT_ENV'] || 'development']
  end
end
