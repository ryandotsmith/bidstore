class CustomersController < ApplicationController

  def new
    @customer = Customer.new
  end#new

  def create 
    @customer = Customer.new( params[:customer] )
    if @customer.save
      flash[:success] = "added #{@customer.name} to the database."
      redirect_to @customer
    else
      render :action => :new
    end
  end#create

  def show
    @customer = Customer.find( params[:id] )
  end#show

  def index
    @customers = Customer.find(:all)
  end#index


end#class