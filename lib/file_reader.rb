require 'pp'
require 'csv'
require 'optparse'
require 'rubygems'
require 'rake'
require 'bundler/setup'
Bundler.require
$LOAD_PATH << File.join(File.dirname(__FILE__))
require 'db_base'
require 'zipcode'
require 'logging'
require 'geocode'
include Logging

ENV['SCRIPT_ENV'] ||= 'development'

class FileReader
  
  def self.option_parser(args = ARGV)
    opts = OptionParser.new
    opts.on("-t", "--truncate")                   { ZipCode.delete_all }
    opts.on("-l LEVEL", "--level LEVEL", String)  { |level| logger.set_log_level(level) }
    opts.on("-h", "--help")                       { puts opts.to_s; exit }
    opts.parse(args)
  end
  
  def self.read_zipcodes
    filename = File.join(File.dirname(__FILE__), '..', 'zipcode.csv')
    options = {
      :headers => true
    }
    row_number = 0
    count = 0
    CSV.foreach(filename, options) do |row|
      row_number += 1
      next if row.size == 0
      attributes = {}
      row.headers.each { |field| attributes[field.to_sym] = row[field] }
      zipcode = ZipCode.create(attributes)
      count += 1
      print '.' if row_number % 1000 == 0
    end
    print "\n"
    logger.info "#{count} zip codes inserted out of #{row_number} lines read"
  end
end

# Run from the command line
if __FILE__ == $0
  # First we want to set the log level if that option is passed in
  index = ARGV.index('-l')
  if index
    level = ARGV[index..index+1]
    FileReader.option_parser(level)
    level.each { |arg| ARGV.delete(arg) }
  end

  # Evaluate command-line arguments (if any)
  FileReader.option_parser(ARGV)
  
  STDOUT.sync = true

  # Read and process the zip codes
  FileReader.read_zipcodes
  
  # Find a zip
  zipcode = ZipCode.find('75019')
  logger.info "#{zipcode.zip} is #{zipcode.city}, #{zipcode.state}"

  geocode = Geocode.reverse_geocode(zipcode.zip)
  unless geocode.nil?
    logger.info "Stands4 says the lat/lng is #{geocode['latitude']},#{geocode['longitude']}, and our database says it's #{zipcode.latitude}, #{zipcode.longitude}."
  end
end
