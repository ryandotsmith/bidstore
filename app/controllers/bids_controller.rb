class BidsController < ApplicationController
  def new
    @bid = Bid.new
  end

  def create
    @bid = Bid.new( params[:bid] )
    if @bid.save
      flash[:success] = "new bid was created"
      redirect_to @bid
    else
      render :action => 'new'
    end
  end

  def show
  end

end
