# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_180_620_122_040) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'open_hours', force: :cascade do |t|
    t.bigint 'restaurant_id'
    t.integer 'weekday'
    t.string 'open_at'
    t.string 'close_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['restaurant_id'], name: 'index_open_hours_on_restaurant_id'
  end

  create_table 'restaurants', force: :cascade do |t|
    t.bigint 'fid'
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['fid'], name: 'index_restaurants_on_fid'
  end
end
