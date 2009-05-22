
Factory.define :customer do |c|
  c.name          { "ACME" }
  c.powerpro_id   { "#{ rand(100) }"}
end

Factory.define :bid do |b|
  b.comments      { "We will win new business with bids like these!" }
  b.association :customer , :factory => :customer
end

Factory.define :lane do |l|
  l.association :bid, :factory => :bid
  l.association :origin_location
  l.association :destination_location
end

Factory.define :location do |location|
  location.location_string    { "Kansas City" }
end