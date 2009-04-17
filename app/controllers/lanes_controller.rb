class LanesController < ApplicationController
  ORIGIN = 0
  DESTINATION = 1

  def new
    @lane = Lane.new
    @lane.build_origin_location
    @lane.build_destination_location
  end 

  def create
    @lane = Lane.new( params[:lane] )
    if @lane.save
      flash[:success] = "success! Lane was created "
      redirect_to @lane
    else
      render :action => 'new'
    end
  end
  
  def index
    @lanes = Lane.find( :all )
  end
  
  def show
    @lane = Lane.find( params[:id] )
  end

end
