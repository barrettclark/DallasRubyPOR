require 'pp'
require 'csv'
require 'rubygems'
require 'bundler/setup'
Bundler.require
$LOAD_PATH << File.join(File.dirname(__FILE__))
require 'db_base'
require 'zipcode'

ENV['SCRIPT_ENV'] ||= 'development'

class FileReader

  def self.read_zipcodes
    filename = File.join(File.dirname(__FILE__), '..', 'zipcode.csv')
    options = {
      :headers => true
    }
    CSV.foreach(filename, options) do |row|
      next if row.size == 0
      attributes = {}
      row.headers.each { |field| attributes[field.to_sym] = row[field] }
      zipcode = ZipCode.create(attributes)
    end
  end
end

# Run from the command line
if __FILE__ == $0
  # Read and process the zip codes
  FileReader.read_zipcodes
  
  # Find a zip
  zipcode = ZipCode.find('75019')
  puts "#{zipcode.zip} is #{zipcode.city}, #{zipcode.state}"
end
