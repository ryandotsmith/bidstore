class SeekersController < ApplicationController

  def search
    @results  = Seeker.new( params[:search_q] ).run()
  end
  
end
