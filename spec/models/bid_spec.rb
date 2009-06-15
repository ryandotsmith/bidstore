require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Bid do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Bid.create!(@valid_attributes)
  end
end

describe "creating a bid along with lanes" do
  before(:each) do
    fake_geocode = OpenStruct.new(:lat => 123.456, :lng => 123.456, :success => true)
    GeoKit::Geocoders::MultiGeocoder.stub!(:geocode).and_return(fake_geocode)
  end

  it "should create lanes only if there location string has a value" do
    params = {'lanes_attributes' => { "12345" => { 
                "origin_location_attributes"=> {"mode"=>"0", "location_string"=>""},
                "destination_location_attributes"=> {"mode"=>"1", "location_string"=>""} 
                }
              }
            }
    bid = Bid.create( params )
    bid.lanes.empty?().should eql( true )
    #bid.lanes.first.origin_location.should eql( 8 )
  end

  it "should create lanes only if there location string has a value" do
    params = {'lanes_attributes' => { "12345" => { 
                "origin_location_attributes"=> {"mode"=>"0", "location_string"=>"ks"},
                "destination_location_attributes"=> {"mode"=>"1", "location_string"=>"ca"} 
                }
              }
            }
    bid = Bid.create( params )
    bid.lanes.empty?().should eql( false )
    #bid.lanes.first.origin_location.should eql( 8 )
  end


end

describe "take an array of lanes and save them with the bid" do
    before(:each) do
      fake_geocode = OpenStruct.new(:lat => 123.456, :lng => 123.456, :success => true)
      GeoKit::Geocoders::MultiGeocoder.stub!(:geocode).and_return(fake_geocode)

      @input = FasterCSV.generate do |csv|
        csv << [  "origin_zip","origin_city","origin_state","destination_zip","destination_city","destination_state",
                  "miles","volume","rates_per_mile",
                  "flat_rate_charge", "lane_capacity", "trailer_type", "lane_acceptance",
                  "comments", "check_all" ]
        csv << [ nil,nil,"kansas",nil,nil, "california", "999", "100 pallets","8.99",nil,nil,"reefer","true","good lane",nil]
      end
    end
    
    it "should save lanes that are unique to the bid" do
      
    end
    
    it "should only save lanes and locations when the bid is saved" do
      @bid  = Factory( :bid )
      lanes = Lane.build_from(@input)
      Bid.count.should eql( 1 )
      Lane.count.should eql( 0 )
      Location.count.should eql( 0 )
      @bid.lanes << lanes
      Lane.count.should eql( 1 )
      Location.count.should eql( 2 )      
    end
    it "should have all attributes saved upon the saving of a bid" do
      @bid  = Factory( :bid )      
      lanes = Lane.build_from(@input)
      @bid.lanes << lanes
      @bid.save
      @bid.lanes.first.origin_location.location_string.should_not eql( nil )
      @bid.lanes.first.destination_location.location_string.should_not eql( nil )
    end

end# desc take lanes and save them with bid

