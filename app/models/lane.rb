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

  def self.determine_location( type, row )
    if !row[ type.to_s + "_zip"].nil?
      return row[type.to_s + "_zip"]
    elsif !row[type.to_s + "_city"].nil?
      return row[type.to_s + "_city"]
    elsif !row[type.to_s + "_state"].nil?
      return row[type.to_s + "_state"]
    else
      ""
    end
  end# determine_location

  def self.build_from( input )
    results,array = [],[]    
    FasterCSV.new( input , :headers => true).each {|row| array << row.to_hash }
    array.each do |row|
      lane = Lane.new( 
                  :comments       => row['comments'], 
                  :trailer_type   => row['trailer_type'],
                  :price          => row['price'],
                  :miles          => row['miles'],
                  :volume         => row['volume'],
                  :price          => row['rate_per_mile'])
      lane.build_origin_location( :location_string => Lane.determine_location( :origin, row ), :mode => 0 )
      lane.build_destination_location( :location_string => Lane.determine_location( :destination, row ), :mode => 1 )
      results << lane
    end#do 
    return( results )
  end

  def ==( other ) 
    self.origin_location.location_string == other.origin_location.location_string and 
      self.destination_location.location_string == other.destination_location.location_string
  end

  def is_unique?
    !Lane.all.any? { |lane| self == lane }
  end

  ####################
  #self.gi
  def self.gi
    @input = FasterCSV.generate do |csv|
      csv << [  "origin_zip","origin_city","origin_state","destination_zip","destination_city","destination_state",
                "miles","volume","rates_per_mile",
                "flat_rate_charge", "lane_capacity", "trailer_type", "lane_acceptance",
                "comments", "check_all" ]
      csv << [ nil,nil,"kansas",nil,nil, "california", "999", "100 pallets","8.99",nil,nil,"reefer","true","good lane",nil]
    end
      @input
  end#self.gi

end


