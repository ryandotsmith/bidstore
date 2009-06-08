class BidsController < ApplicationController
  before_filter :load_customer, :only => [ :new,:create ]
  def index
    @bids = Bid.find( :all )
  end

  def show
    @bid = Bid.find( params[:id] )
  end

  def new
    @bid  = @customer.bids.build
    @bid.lanes.build
    @bid.lanes.each { |lane| lane.build_origin_location      }
    @bid.lanes.each { |lane| lane.build_destination_location }
  end

  def create
    @bid = @customer.bids.build( params[:bid] )
    if @bid.save
      flash[:success] = "new bid was created for customer #{@customer.id}"
      redirect_to @bid unless @bid.lanes.empty?
      redirect_to edit_bid_path( @bid ) if @bid.lanes.empty?
    else
      render :action => 'new'
    end
  end
  
  def edit
    @bid = Bid.find( params[:id] )
  end

  def update
    @bid = Bid.find( params[:id] )
    if @bid.update_attributes( params[:bid] )
      flash[:success] = "your bid was updated!"
      redirect_to @bid
    end
  end
  
protected
  ####################
  #load_customer
  def load_customer
    @customer = Customer.find( params[:customer_id] )
  end#load_customer

end
