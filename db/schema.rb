# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090604031144) do

  create_table "bids", :force => true do |t|
    t.integer  "customer_id"
    t.text     "comments"
    t.integer  "status",                   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "import_data_file_name"
    t.string   "import_data_content_type"
    t.integer  "import_data_file_size"
    t.datetime "import_data_updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "powerpro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lanes", :force => true do |t|
    t.integer  "bid_id"
    t.integer  "status",                :default => 0
    t.float    "price"
    t.float    "price_min"
    t.string   "price_mode"
    t.string   "special_requirements"
    t.string   "volume_committed"
    t.string   "trailer_type"
    t.string   "business_relationship"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.integer  "lane_id"
    t.integer  "mode"
    t.float    "lat"
    t.float    "lng"
    t.string   "location_string"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
