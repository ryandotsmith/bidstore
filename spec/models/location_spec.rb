require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
  
  describe "filtering query parameters" do    
    it "should pick out bids" do      
      string = "bids: 66216 - california"
      result = {:objects => 'bids', :origin => '66216', :destination => 'california' }
      @seeker = Seeker.new(string)
  		@seeker.filter_query().should == (result)      
    end

    it "should pick out lanes" do      
      string = "lanes: 66216 - california"
      result = {:objects => 'lanes', :origin => '66216', :destination => 'california' }
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
    it "should handle queries that are looking only for a destination" do
  		string = "lanes:64105-Oklahoma"
      result = { :objects => "lanes", :origin => "64105", :destination => "Oklahoma"}
      @seeker = Seeker.new(string)
  		@seeker.filter_query().should == (result)
	  end
  end

#Location.find( :all, :origin => '66216', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',0])
