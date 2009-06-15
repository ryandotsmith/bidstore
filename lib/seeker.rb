require 'extensions/all'
class String
  def peel()
    return nil if self.length.zero?
    self.strip
  end
end

class Seeker
  attr_accessor :origin, :destination, :includes, :query
  def initialize(  string, radius=150, object=nil )
    @q_string     =   string
    @includes     =   []
    @radius       =   radius
    @scope_object =   object      
  end

  def run()
    self.filter_query()
    self.build_query()
    self.scope( self.execute() )
  end

  def filter_query()                                         	
    # if the query specifies an object, pick it from string
    if !@q_string.scan(/:/).length.zero? # string has a : and possibly a -
      @includes << @q_string.split(':').first.strip
      remainder = @q_string.split(':').second
      if !remainder.scan(/-/).length.zero? #string has a -
        remainder.strip!
        if remainder.starts_with?('-') # no origin was defined 
          @destination = remainder.split('-').last.strip.peel
        elsif remainder.ends_with?('-')# no destination was defined
          @origin      = remainder.split('-').first.strip.peel
        else # ambiguous location 
          @origin      = remainder.split('-').first.strip.peel  
          @destination = remainder.split('-').last.strip.peel 
        end
      else # string does not have a -
        @origin      =	remainder.strip
        @destination =  remainder.strip
      end 
    elsif !@q_string.scan(/-/).length.zero? # string has - but not a :
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
      @query << "Location.find( :all, :origin => '#{@origin}', :include => [:lane => [:bid => [:customer]]], :within => #{@radius}, :conditions => ['mode=?',0])"
      @query << "Location.find( :all, :origin => '#{@destination}', :include => [:lane => [:bid => [:customer]]], :within => #{@radius}, :conditions => ['mode=?',1])"

    elsif @origin and @destination.nil?
      @query << "Location.find( :all, :origin => '#{@origin}', :include => [:lane => [:bid => [:customer]]], :within => #{@radius}, :conditions => ['mode=?',0])"

    elsif @destination and @origin.nil?
      @query << "Location.find( :all, :origin => '#{@destination}', :include => [:lane => [:bid => [:customer]]], :within => #{@radius}, :conditions => ['mode=?',1])"  
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
      return  { :lanes => lanes.uniq, :bids => bids.uniq }
    end

    if @includes.include?('bids') and !@includes.include?('lanes')
      return { :bids => bids.uniq }
    end

    if !@includes.include?('bids') and @includes.include?('lanes')
      return { :lanes => lanes.uniq  }
    end
    
  end#def

  def scope( results )
    bids, lanes = nil, nil
    require "rubygems"; require "ruby-debug"; debugger 
    case @scope_object.class.to_s
      when "Bid"
        return results if results[:lanes].nil?
        lanes = results[:lanes].find_all { |l| l.bid_id == @scope_object.id }
      when "Customer"
        return results if results[:bids].nil?
        bids = results[:bids].find_all { |l| l.customer_id == @scope_object.id }
      when "NilClass"
        # no object was specified so return reulst provided by execute()
        return( results )
    end#case
    { :bids => bids, :lanes => lanes }
  end#def

end
