require 'logger'

module Logging
  # http://stackoverflow.com/questions/917566/ruby-share-logger-instance-among-module-classes
  # This is the magical bit that gets mixed into your classes
  def logger
    Logging.logger
  end

  # Global, memoized, lazy initialized instance of a logger
  def self.logger
    @logger ||= Logging.brand_new_logger
  end
  
  def set_log_level(level)
    case level
    when 'DEBUG'
      logger.level = Logger::DEBUG
    when 'INFO'
      logger.level = Logger::INFO
    when 'WARN'
      logger.level = Logger::WARN
    when 'ERROR'
      logger.level = Logger::ERROR
    when 'FATAL'
      logger.level = Logger::FATAL
    else
      logger.level = Logger::DEBUG
    end
  end

  protected
  def self.brand_new_logger
    if ENV['SCRIPT_ENV']
      filename = File.join(File.expand_path(File.dirname(__FILE__)), '..', 'log', ENV['SCRIPT_ENV'] + '.log')
      Logger.new(filename)
    else
      Logger.new(STDOUT)
    end
  end
end
