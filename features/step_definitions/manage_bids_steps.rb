Given /^I visit the new bid page$/ do
  @customer = Factory( :customer )
  visit( new_customer_bid_url( @easy_factory_object ) )
end

