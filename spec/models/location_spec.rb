require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "search" do
  
  describe "filtering model parameters" do
    
    it "should pick out bids" do      
      string = "bids: 66216 - california"
      Location.filter_query( string ).should == ( {:objects => 'bids', :origin => '66216', :destination => 'california' } )
    end

    it "should pick out lanes" do      
      string = "lanes: 66216 - california"
      Location.filter_query( string ).should == ( {:objects => 'lanes', :origin => '66216', :destination => 'california' } )
    end
    
    it "should handle request without object type" do
      string = "66216 - Kansas City"
      Location.filter_query( string ).should == ( {:objects => nil, :origin => '66216', :destination => 'Kansas City' } )
    end
    
    it "should handle a request wiht one parameter" do
      string = "Oklahoma"
      Location.filter_query( string ).should == ( {:objects => nil, :origin => 'Oklahoma', :destination => nil } )
    end

    
    
  end  
  
end

#Location.find( :all, :origin => '66216', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',0])