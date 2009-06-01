require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe "search" do

  describe "filtering query parameters" do    

    it "should pick out bids" do      
      string = "bids: 66216 - california"
      @seeker = Seeker.new(string)
      @seeker.filter_query()    

      @seeker.origin.should == '66216'
      @seeker.destination.should == 'california'
      @seeker.includes.should == ['bids']
    end

    it "should pick out lanes with orig and dest defined" do      
      string = "lanes: 66216 - california"
      @seeker = Seeker.new(string)
      @seeker.filter_query()

      @seeker.origin.should == '66216'
      @seeker.destination.should == 'california'
      @seeker.includes.should == ['lanes']
    end

    it "should pick out lanes with no spec" do      
      string = "lanes: 66216 "
      @seeker = Seeker.new(string)
      @seeker.filter_query()
      
      @seeker.origin.should == '66216'
      @seeker.destination.should == '66216'
      @seeker.includes.should == ['lanes']
      
    end

    it "should pick out lanes with dest defined" do      
      string = "lanes: -66216 "
      @seeker = Seeker.new(string)
      @seeker.filter_query()
      
      @seeker.origin.should == nil
      @seeker.destination.should == '66216'
      @seeker.includes.should == ['lanes']
      
    end

    it "should pick out lanes with dest defined" do      
      string = "lanes: 66216- "
      @seeker = Seeker.new(string)
      @seeker.filter_query()
      
      @seeker.origin.should == '66216'
      @seeker.destination.should == nil
      @seeker.includes.should == ['lanes']
      
    end

    it "should handle request without object type" do
      string = "66216 - Kansas City"
      @seeker = Seeker.new(string)
      @seeker.filter_query()
      
      @seeker.origin.should == "66216"
      @seeker.destination.should == "Kansas City"
      @seeker.includes.should == ['lanes','bids']
    end

    it "should handle a request wiht one parameter" do
      string = "Oklahoma"
      @seeker = Seeker.new(string)
      @seeker.filter_query()
      
      @seeker.origin.should == "Oklahoma"
      @seeker.destination.should == "Oklahoma"
      @seeker.includes.should == ['lanes','bids']
    end    

    it "should handle a request with only orig defined" do
      string = "Oklahoma-"
      @seeker = Seeker.new(string)
      @seeker.filter_query()

      @seeker.origin.should == "Oklahoma"
      @seeker.destination.should == nil
      @seeker.includes.should == ['lanes','bids']      
    end    

    it "should handle a request with only destination defined" do
      string = "-Oklahoma"
      @seeker = Seeker.new(string)
      @seeker.filter_query()
      
      @seeker.origin.should == nil
      @seeker.destination.should == "Oklahoma"
      @seeker.includes.should == ['lanes','bids']
    end    

    it "pick out lanes" do
      string = "lanes:64105-Oklahoma"
      @seeker = Seeker.new(string)
      @seeker.filter_query()
      
      @seeker.origin.should == "64105"
      @seeker.destination.should == "Oklahoma"
      @seeker.includes.should == ['lanes']      
    end
  end # describe filter

  describe "building a find query based on the filtered result" do
    it "should do something" do
      @seeker = Seeker.new("66216-")
      @seeker.filter_query()
      result = []
      result << "Location.find( :all, :origin => '66216', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',0])"
      @seeker.build_query().length.should == 1
      @seeker.build_query().should == result
    end

    it "should do something" do
      @seeker = Seeker.new("-66216")
      @seeker.filter_query()
      result = []
      result << "Location.find( :all, :origin => '66216', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',1])"
      @seeker.build_query().length.should == 1
      @seeker.build_query().should == result
    end

    it "should " do
      @seeker = Seeker.new("66216-64105")
      @seeker.filter_query()
      result = []
      result << "Location.find( :all, :origin => '66216', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',0])"
      result << "Location.find( :all, :origin => '64105', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',1])"
      @seeker.build_query().length.should == 2
      @seeker.build_query().should == result
    end

  end # des building query

  describe "checking the results of the queries" do
    it "should find " do
      @location_one = Factory( :location, :location_string => "66216", :mode => 0)
      @location_two = Factory( :location, :location_string => "64105", :mode => 1)

      @location_three = Factory( :location, :location_string => "alabama", :mode => 0)
      @location_four  = Factory( :location, :location_string => "california", :mode => 1)


      @customer = Factory( :customer )
      @bid      = Factory( :bid      )
      @lane     = Factory( :lane, :origin_location      =>  @location_one,
                                  :destination_location =>  @location_two)
      string = "bids: -66216"
      @seeker = Seeker.new( string )
      @seeker.filter_query()
      @seeker.origin.should == nil
    end

  end

  describe "executing the query and combining the results" do
    before(:each) do
      @location_one = Factory( :location, :location_string => "66216", :mode => 0)
      @location_two = Factory( :location, :location_string => "64105", :mode => 1)

      @location_three = Factory( :location, :location_string => "new york", :mode => 0)
      @location_four  = Factory( :location, :location_string => "california", :mode => 1)


      @customer = Factory( :customer                     )
      @bid      = Factory( :bid , :customer => @customer )

      @lane     = Factory( :lane, :bid      => @bid,
                                  :origin_location      =>  @location_one,
                                  :destination_location =>  @location_two )

      @lane_one = Factory( :lane, :bid      => @bid,
                                  :origin_location      =>  @location_three,
                                  :destination_location =>  @location_four )      
    end#before

    it "should only return bids" do
      string = "bids: -64105"
      @seeker = Seeker.new( string )
      @seeker.filter_query()
      @seeker.build_query()
      @seeker.execute().all? {|object| object.class.to_s == "Bid"}.should eql( true )
      @seeker.execute().all? {|object| object.class.to_s == "Lane"}.should eql( false )
    end

    it "should only return lanes" do
      string = "lanes: -64105"
      @seeker = Seeker.new( string )
      @seeker.filter_query()
      @seeker.build_query()
      @seeker.execute().all? {|object| object.class.to_s == "Lane"}.should eql( true )
      @seeker.execute().any? {|object| object.class.to_s == "Bid"}.should eql( false )      
    end

    it "should return lanes and bids" do
      string = "newyork-California"
      @seeker = Seeker.new( string )
      @seeker.filter_query()
      @seeker.build_query()
      @seeker.execute().any? {|object| object.class.to_s == "Lane"}.should eql( true )
      @seeker.execute().any? {|object| object.class.to_s == "Bid"}.should eql( true )      
    end

    it "should return lanes and bids" do
      string = "California"
      @seeker = Seeker.new( string )
      @seeker.filter_query()
      @seeker.build_query()
      @seeker.execute().any? {|object| object.class.to_s == "Lane"}.should eql( true )
      @seeker.execute().any? {|object| object.class.to_s == "Bid"}.should eql( true )      
    end


  end



end # end search

