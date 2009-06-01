class String
  def peel()
    return nil if self.length.zero?
    self.strip
  end
end

class Seeker
  attr_accessor :origin, :destination, :includes, :query
  def initialize( string )
    @q_string     =   string
    @includes     =   []
  end

  def run()
    self.filter_query()
    self.build_query()
    self.execute()
  end

  def filter_query()                                         	
    # if the query specifies an object, pick it from string
    if !@q_string.scan(/:/).length.zero? # string has a :
      @includes << @q_string.split(':').first.strip
      remainder = @q_string.split(':').second
      if !remainder.scan(/-/).length.zero? #string has a -
        @origin      = remainder.split('-').first.strip.peel  unless remainder.split('-').first.length.zero?
        @destination = remainder.split('-').last.strip.peel unless remainder.split('-').last.length.zero? 
      else # string does not have a -
        @origin      =	remainder.strip
        @destination =  remainder.strip
      end 
    elsif !@q_string.scan(/-/).length.zero? # string has -
      @includes = ['lanes','bids']
      if @q_string.first == "-"
        @destination = @q_string.split('-').last.strip
      elsif @q_string.last == "-" 
        @origin = @q_string.split('-').first.strip
      else
        @origin      = @q_string.split('-').first.strip
        @destination = @q_string.split('-').last.strip
      end
    else
      @includes = ['lanes','bids']
      @origin      = @q_string
      @destination = @q_string
    end
    { :objects => @includes.first, :origin => @origin, :destination => @destination }
  end

  def build_query()
    @query = Array.new

    if @origin and @destination
      @query << "Location.find( :all, :origin => '#{@origin}', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',0])"
      @query << "Location.find( :all, :origin => '#{@destination}', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',1])"

    elsif @origin and @destination.nil?
      @query << "Location.find( :all, :origin => '#{@origin}', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',0])"

    elsif @destination and @origin.nil?
      @query << "Location.find( :all, :origin => '#{@destination}', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',1])"  
    end

    return @query
  end
  
  def execute()
    locations = Array.new
    lanes     = Array.new
    bids      = Array.new

    @query.each {|statement| locations << eval( statement) }
    locations.flatten!

    if @includes.include?( 'lanes' )
      locations.each do |location|
        lanes << location.lane
      end
    end#if
        
    if @includes.include?( 'bids' )
      locations.each do |location|
        bids << location.lane.bid 
      end # do lane
    end #if
    
    if @includes.include?('bids') and @includes.include?('lanes')
      return  { :lanes => lanes, :bids => bids }
    end

    if @includes.include?('bids') and !@includes.include?('lanes')
      return { :bids => bids }
    end

    if !@includes.include?('bids') and @includes.include?('lanes')
      return { :lanes => lanes  }
    end
    
  end#def

end
