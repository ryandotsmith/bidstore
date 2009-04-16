ActionController::Routing::Routes.draw do |map|
  map.resources :customers, :has_many => [ :bids ]
  map.resources :bids
  map.resources :lanes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end



