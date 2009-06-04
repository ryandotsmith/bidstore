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

