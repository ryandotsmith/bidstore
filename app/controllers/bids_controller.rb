class BidsController < ApplicationController
  before_filter :load_customer, :only => [ :new,:create ]
  def index
    @bids = Bid.find( :all )
  end

  def new
    @bid  = @customer.bids.build
    2.times {@bid.lanes.build}
    @bid.lanes.each { |lane| lane.build_origin_location      }
    @bid.lanes.each { |lane| lane.build_destination_location }
  end

  def create
    @bid = @customer.bids.build( params[:bid] )
    if @bid.save
      flash[:success] = "new bid was created for customer #{@customer.id}"
      redirect_to @bid
    else
      render :action => 'new'
    end
  end

  def show
    @bid = Bid.find( params[:id] )
  end
  
protected
  ####################
  #load_customer
  def load_customer
    @customer = Customer.find( params[:customer_id] )
  end#load_customer

end
