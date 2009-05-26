class String
  def peel()
    return nil if self.length.zero?
    self.strip
  end
end

class Seeker
  attr_accessor :origin, :destination, :includes

  def initialize( string )
    @q_string     =   string
    @includes     =   []
  end

  def filter_query()                                         	
    # if the query specifies an object, pick it from string
    if !@q_string.scan(/:/).length.zero? # string has a :
      @includes << @q_string.split(':').first.strip
      remainder = @q_string.split(':').second
      if !remainder.scan(/-/).length.zero?
        @origin      = remainder.split('-').first.strip  unless remainder.split('-').first.length.zero?
        @destination = remainder.split('-').last.strip unless remainder.split('-').last.length.zero? 
      else
        @origin      =	remainder.strip
        @destination =  remainder.strip
      end 
    elsif !@q_string.scan(/-/).length.zero? # string has -
      if @q_string.first == "-"
        @destination = @q_string.split('-').last.strip
      elsif @q_string.last == "-" 
        @origin = @q_string.split('-').first.strip
      else
        @origin      = @q_string.split('-').first.strip
        @destination = @q_string.split('-').last.strip
      end
    else
      @origin      = @q_string
      @destination = @q_string
    end
    { :objects => @includes.first, :origin => @origin, :destination => @destination }
  end

  def build_query()
    query = Array.new
    if @origin and @destination
      query << "Location.find( :all, :origin => '#{@origin}', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',0])"
      query << "Location.find( :all, :origin => '#{@destination}', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',1])"
    elsif @origin and !@destination
      query << "Location.find( :all, :origin => '#{@origin}', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',0])"
    elsif @destination and !@origin
      query << "Location.find( :all, :origin => '#{@destination}', :include => [:lane => [:bid => [:customer]]], :within => 25, :conditions => ['mode=?',1])"  
    end
    query
  end
  
end
