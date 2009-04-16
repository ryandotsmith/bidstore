class LanesController < ApplicationController

  def new
    @lane = Lane.new
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
end
