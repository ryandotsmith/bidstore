ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'customers', :action => 'index'
  
  map.resources :settings
  
  map.resources :customers do |customers|
    customers.resources :bids, :name_prefix => 'customer_'
  end

  map.resources :bids do |bids|
    bids.resources :lanes, :name_prefix => 'bid_'
  end

  map.resources :lanes do |lanes|
    lanes.resources :locations, :name_prefix => 'lane_'
  end

  map.resources :locations

end



