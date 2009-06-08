Given /^I visit the new bid page$/ do
  @customer = Factory( :customer )
  visit( new_customer_bid_url( @easy_factory_object ) )
end

Given /^I visit the show bid page$/ do
  visit customer_bid_url( @easy_factory_object.customer, @easy_factory_object  ) 
end
