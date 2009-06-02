class SeekersController < ApplicationController

  def search
    @results  = Seeker.new( params[:search_q], params[:radius] ).run()
  end
  
end
