class String
  def peel()
    return nil if self.length.zero?
    self.strip
  end
end

class Seeker

  def initialize( string )
    @q_string     =   string
    @origin       =   String.new
    @destination  =   String.new
    @includes     =   Array.new
  end

  def filter_query()                                         	
    # if the query specifies an object, pick it from string
    if !@q_string.scan(/:/).length.zero? # string has a :
      @includes << @q_string.split(':').first
      remainder = @q_string.split(':').second
      if !remainder.scan(/-/).length.zero?
        @origin      = remainder.split('-').first  unless remainder.split('-').first.length.zero?
        @destination = remainder.split('-').last unless remainder.split('-').last.length.zero? 
      else
        @origin      =	remainder
        @destination =  remainder
      end 
    elsif !@q_string.scan(/-/).length.zero? # string has -
      if @q_string.first == "-"
        @destination = @q_string.split('-').last
      elsif @q_string.last == "-" 
        @origin = @q_string.split('-').first
      else
        @origin      = @q_string.split('-').first
        @destination = @q_string.split('-').last
      end
    else
      @origin      = @q_string
      @destination = @q_string
    end
    { :objects => @includes.first, :origin => @origin.peel, :destination => @destination.peel }
  end

end
