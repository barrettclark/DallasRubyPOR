class ZipCode
  attr_accessor :zip, :city, :state, :latitude, :longitude, :timezone, :dst
  
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
  
  def timezone_name
    TIMEZONES[@timezone]
  end
  
  def dst?
    @dst == 1
  end
end
