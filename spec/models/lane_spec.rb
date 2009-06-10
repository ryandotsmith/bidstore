require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Lane do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Lane.create!(@valid_attributes)
  end
end

describe "building a new lane with location" do
  before(:each) do
    params = {}
  
  end

end

describe "making lanes from a CSV File" do

  before(:each) do
    @input = FasterCSV.generate do |csv|
      csv << [  "origin","destination","miles","volume","rates_per_mile",
                "flat_rate_charge", "lane_capacity", "trailer_type", "lane_acceptance",
                "comments", "check_all"]
      csv << [ "kansas", "california", "999", "100 pallets","8.99","","","reefer","true","good lane",""]
    end
  end
  it "should return an array of lanes from CSV input" do
    location_one = Factory( :location, :location_string => "kansas", :mode => 0)
    location_two = Factory( :location, :location_string => "california", :mode => 1)
    customer = Factory( :customer )
    bid      = Factory( :bid      )
    lane     = Factory( :lane, :origin_location      =>  location_one,
                                :destination_location => location_two )
    
    Lane.build_from( @input ).first.origin_location.location_string.should eql( "kansas" )
  end
end


