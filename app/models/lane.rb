class Lane < ActiveRecord::Base
  has_many :locations
  belongs_to :bid
  # Mode = 0 => that the location object is an origin location 
  has_one :origin_location, :class_name => "Location", :conditions => "mode = 0"
  accepts_nested_attributes_for :origin_location
  # Mode = 1 => that the location object is an origin location 
  has_one :destination_location, :class_name => "Location", :conditions => "mode = 1"
  accepts_nested_attributes_for :destination_location

  def self.prep
    lane = Lane.new
    lane.build_origin_location
    lane.build_destination_location
    lane
  end

end
