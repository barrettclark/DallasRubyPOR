class ZipCode
  attr_accessor :zip, :city, :state, :latitude, :longitude, :timezone, :dst
  
  def initialize(attributes = {})
    @zip = attributes[:zip]
    @city = attributes[:city]
    @state = attributes[:state]
    @latitude = attributes[:latitude]
    @longitude = attributes[:longitude]
    @timezone = attributes[:timezone]
    @dst = attributes[:dst]
  end
end
