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
  
  def self.build_from( input )
    results,array = [],[]    
    FasterCSV.new( input , :headers => true).each {|row| array << row.to_hash }
    array.each do |row|
      lane = Lane.new( 
                  :comments       => row['comments'], 
                  :trailer_type   => row['trailer_type'],
                  :price          => row['price'])
      lane.build_origin_location(:location_string => row['origin'])
      lane.build_destination_location(:location_string => row['destination'])
      results << lane
    end#do 
    return( results )
  end


end


