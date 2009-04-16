
Factory.define :customer do |c|
  c.name          { "ACME" }
  c.powerpro_id   { "#{ rand(100) }"}
end