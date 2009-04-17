class BidsController < ApplicationController

  def new
    @bid = @customer.bids.build
  end

  def create
    @bid = @customer.bids.build( params[:bid] )
    if @bid.save
      flash[:success] = "new bid was created"
      redirect_to @bid
    else
      render :action => 'new'
    end
  end

  def show
  end
protected

  ####################
  #load_customer
  def load_customer
    @customer = Customer.find( params[:customer_id] )
  end#load_customer

end
