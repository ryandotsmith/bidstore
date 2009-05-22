class Seeker

  def initialize( string )
    @q_string = string
  end

  def filter_query()                                         	
    # if the query specifies an object, pick it from string
    if !@q_string.scan(/:/).length.zero?
      objects   = @q_string.split(':').first 
      remainder = @q_string.split(':').second
      if !remainder.scan(/-/).length.zero?
        origin      = remainder.split('-').first
        destination = remainder.split('-').second        
      end 
    elsif !@q_string.scan(/-/).length.zero?
      origin      = @q_string.split('-').first
      destination = @q_string.split('-').second
    else
      origin      = @q_string.strip
      destination = @q_string.strip
    end
    { :objects => objects, :origin => origin.strip, :destination => destination.strip }
	end

end
