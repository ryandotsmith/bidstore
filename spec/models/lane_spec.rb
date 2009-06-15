require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "wrapping tests to stub any calls to geocoding" do

  before(:each) do
    fake_geocode = OpenStruct.new(:lat => 123.456, :lng => 123.456, :success => true)
    GeoKit::Geocoders::MultiGeocoder.stub!(:geocode).and_return(fake_geocode)
  end

  describe "taking an input file and returning an array of lanes" do
    before(:each) do
      @input = FasterCSV.generate do |csv|
        csv << [  "origin_zip","origin_city","origin_state","destination_zip","destination_city","destination_state",
                  "miles","volume","rates_per_mile",
                  "flat_rate_charge", "lane_capacity", "trailer_type", "lane_acceptance",
                  "comments", "check_all" ]
        csv << [ nil,nil,"kansas",nil,nil, "california", "999", "100 pallets","8.99",nil,nil,"reefer","true","good lane",nil]
      end
    end#before
    
    describe "determining the origin and location" do
      # in the input file, the origin and destination may 
      # be represented as a zip or city or state. 
      it "should pick out a state" do
        array = []
        FasterCSV.new( @input , :headers => true).each {|row| array << row.to_hash }
        row   = array.first
        Lane.determine_location( :origin, row ).should eql( "kansas" )
      end
      it "should choose a zip code over a state" do
        row = { 'origin_zip' => '66216', 'origin_city' => nil , 'origin_state' => 'ks' }
        Lane.determine_location( :origin, row ).should eql( "66216" )
      end
      
    end# determine origin and location
    
    it "should not save any data to the DB" do
      lanes = Lane.build_from(@input)
      Lane.count.should eql( 0 )
      Location.count.should eql( 0 )
    end
    it "should have children who are location objects" do
      Lane.build_from(@input).first.origin_location.class.should eql( Location )
      Lane.build_from(@input).first.destination_location.class.should eql( Location )
    end
    it "should return an array" do
      Lane.build_from(@input).class.should eql( Array )
    end
    
  end# desc of taking import file and return array of lanes

  describe "comparing lanes for equality" do

    before(:each) do
      @location_one = Factory( :location, :location_string => "66216", :mode => 0)
      @location_two = Factory( :location, :location_string => "64105", :mode => 1)

      @location_one = Factory( :location, :location_string => "Oklahoma", :mode => 0)
      @location_two = Factory( :location, :location_string => "Nebraska", :mode => 1)


      @location_three = Factory( :location, :location_string => "alabama", :mode => 0)
      @location_four  = Factory( :location, :location_string => "california", :mode => 1)


      @customer = Factory( :customer )
      @bid      = Factory( :bid      )
      @lane_one = Factory( :lane, :origin_location      =>  @location_one,
                                  :destination_location =>  @location_two)
      @lane_one_copy = Factory( :lane, :origin_location      =>  @location_one,
                                  :destination_location =>  @location_two)
      @lane_two = Factory( :lane, :origin_location      =>  @location_three,
                                  :destination_location =>  @location_four)

    end

    it "should be that two lanes are equal if their attrs are equal" do
      ( @lane_one == @lane_one_copy ).should eql( true )
    end

    it "should not be that two lanes are equal if their attrs are equal" do
      ( @lane_one == @lane_two ).should_not eql( true )
    end

  end
  
  describe "the uniqness of lanes" do
    before(:each)do
    end
    it "should use the == operator" do

    end
    it "should find unique lanes with respect to a bid" do

    end
    it "should find similar lanes in a universal context" do
      location_one = Factory( :location, :location_string => "kansas", :mode => 0)
      location_two = Factory( :location, :location_string => "california", :mode => 1)
      lane = Factory( :lane , :origin_location => location_one, :destination_location => location_two)
      lane.is_unique?().should eql( false )
    end

  end

end