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

  def edit
    @customer = Customer.find( params[:id] )
  end

  def update
    @customer = Customer.find( params[:id] )
    respond_to do |format|
      if @customer.update_attributes( params[:customer] )
        format.html { redirect_to @customer }
        format.js
      else
        format.html { render :action => 'edit' }  
      end
    end
  end

end#class