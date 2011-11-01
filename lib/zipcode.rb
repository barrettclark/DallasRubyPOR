class ZipCode < DBBase
  attr_accessor :id, :zip, :city, :state, :latitude, :longitude, :timezone, :dst
  
  TIMEZONES = {
    -5  => 'US/Eastern',
    -6  => 'US/Central',
    -7  => 'US/Mountain',
    -8  => 'US/Pacific'
  }
  
  def initialize(attributes = {})
    @zip = attributes[:zip]
    @city = attributes[:city]
    @state = attributes[:state]
    @latitude = attributes[:latitude].to_f
    @longitude = attributes[:longitude].to_f
    @timezone = attributes[:timezone].to_i
    @dst = attributes[:dst].to_i
  end
  
  # We can insert records into the database easily
  def self.create(attributes = {})
    zipcode = ZipCode.new(attributes)
    zipcode.create
    zipcode
  end
  
  # We can also find records in the database and reconsititute them into
  # ZipCode objects.
  def self.find(zipcode)
    sql = "SELECT * FROM zipcode WHERE zip = '#{zipcode}'"
    result = connection.exec(sql)
    attributes = Hash.new
    result.fields.each_with_index do |field, idx|
      attributes[field.to_sym] = result.column_values(idx).first
    end
    ZipCode.new(attributes)
  end

  def create
    fields = [
      # NOTE: The 'E' is to tell postgres that the string is (potentially) escaped
      'E' + PGconn.quote_connstr(@zip),
      'E' + PGconn.quote_connstr(@city),
      'E' + PGconn.quote_connstr(@state),
      @latitude, @longitude, @timezone, @dst
    ]
    sql = "INSERT INTO zipcode VALUES (#{fields.join(',')})"
    result = ZipCode.connection.exec(sql)
    puts "#{sql}\n  Tuples: #{result.cmd_tuples}" if ENV['SCRIPT_ENV'] == 'test'
    # NOTE: insert queries do not return a result set
    result
  rescue PGError=>e
    puts "#{e}: Unable to insert the zipcode: #{@zipcode}"
  end
  
  def timezone_name
    TIMEZONES[@timezone]
  end
  
  def dst?
    @dst == 1
  end
end
