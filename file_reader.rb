require 'csv'
require File.join(File.dirname(__FILE__), 'zipcode')
require 'pp'

class FileReader
  def self.read_zipcodes
    filename = File.join(File.dirname(__FILE__), 'zipcode.csv')
    options = {
      :headers => true
    }
    CSV.foreach(filename, options) do |row|
      next if row.size != row.headers.size
      attributes = {}
      row.headers.each { |field| attributes[field.to_sym] = row[field] }
      zipcode = ZipCode.new(attributes)
      # pp zipcode
    end
  end
end

# Run from the command line
if __FILE__ == $0
  FileReader.read_zipcodes
end
