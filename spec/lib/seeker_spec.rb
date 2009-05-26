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

    it "should pick out lanes" do      
      string = "lanes: 66216 - california"
      result = {:objects => 'lanes', :origin => '66216', :destination => 'california' }
      @seeker = Seeker.new(string)
      @seeker.filter_query().should == (result)      
    end

    it "should pick out lanes" do      
      string = "lanes: 66216 "
      result = {:objects => 'lanes', :origin => '66216', :destination => '66216'}
      @seeker = Seeker.new(string)
      @seeker.filter_query().should == (result)      
    end

    it "should pick out lanes" do      
      string = "lanes: -66216 "
      result = {:objects => 'lanes', :origin => "", :destination => '66216'}
      @seeker = Seeker.new(string)
      @seeker.filter_query().should == (result)      
    end

    it "should handle request without object type" do
      string = "66216 - Kansas City"
      result = {:objects => nil, :origin => '66216', :destination => 'Kansas City' }
      @seeker = Seeker.new(string)
      @seeker.filter_query().should == (result)      
    end

    it "should handle a request wiht one parameter" do
      string = "Oklahoma"
      result = {:objects => nil, :origin => 'Oklahoma', :destination => "Oklahoma" } 
      @seeker = Seeker.new(string)
      @seeker.filter_query().should == (result)      
    end    

    it "should handle a request wiht one parameter" do
      string = "Oklahoma-"
      result = {:objects => nil, :origin => 'Oklahoma', :destination => nil } 
      @seeker = Seeker.new(string)
      @seeker.filter_query().should == (result)      
    end    

    it "should handle a request wiht one parameter" do
      string = "-Oklahoma"
      result = {:objects => nil, :origin => nil, :destination => "Oklahoma" } 
      @seeker = Seeker.new(string)
      @seeker.filter_query().should == (result)      
    end    

    it "should handle queries that are looking only for a destination" do
      string = "lanes:64105-Oklahoma"
      result = { :objects => "lanes", :origin => "64105", :destination => "Oklahoma"}
      @seeker = Seeker.new(string)
      @seeker.filter_query().should == (result)
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
      search_string = "66216-"
      @seeker = Seeker.new(search_string)
      @seeker.filter_query()
      query = @seeker.build_query()
      eval( query.first ).length.should == 1 
    end

  end

end # end search

