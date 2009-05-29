Given /^I visit the new bid page$/ do
  @customer = Factory( :customer )
  visit( new_customer_bid_url( @easy_factory_object ) )
end

Given /^I visit the show bid page$/ do
  @customer = Factory( :customer )
  @bid      = Factory( :bid, :customer => @customer )
  visit customer_bid_url( @customer, @bid ) 
end
