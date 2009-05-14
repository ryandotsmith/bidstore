class LanesController < ApplicationController
  before_filter :load_bid, :only => [ :new,:create ]

  def index
    @lanes = Lane.find( :all )
  end

  def new
    @lane = @bid.lanes.build
    @lane.build_origin_location
    @lane.build_destination_location
    respond_to do |format|
      format.html
      format.js
    end
  end 

  def create
    @lane = @bid.lanes.build( params[:lane] )
    if @lane.save
      flash[:success] = "success! Lane was created "
      redirect_to @lane
    else
      render :action => 'new'
    end
  end
  
  def show
    @lane = Lane.find( params[:id] )
  end
protected 
  ####################
  #load_bid
  def load_bid
    @bid = Bid.find( params[:bid_id] )
  end#load_bid
end
