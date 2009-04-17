class Location < ActiveRecord::Base
  include Geokit::Mappable
  belongs_to :lane
  acts_as_mappable

  ####################
  #before_save
  def before_save
    geocode_address
  end#before_save
  
  ####################
  #to_s
  def to_s
    result = Geokit::Geocoders::GoogleGeocoder.reverse_geocode(" #{self.lat} , #{self.lng}")
    result.full_address
  end#to_s
  
private

  def geocode_address
    geo=Geokit::Geocoders::MultiGeocoder.geocode(location_string)
    errors.add(:location_string, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

end#Location