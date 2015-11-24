# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 0) do

  create_table "t_Contact_Info", id: false, force: :cascade do |t|
    t.string "first_name",   limit: 30, default: "", null: false
    t.string "last_name",    limit: 30, default: "", null: false
    t.string "phone_number", limit: 11
    t.string "email",        limit: 40
  end

  create_table "t_Sensor_Data", primary_key: "time_recorded", force: :cascade do |t|
    t.float   "wind_speed",     limit: 24
    t.integer "wind_direction", limit: 4
    t.float   "rainfall",       limit: 24
    t.float   "water_level",    limit: 24
    t.float   "water_temp",     limit: 24
    t.float   "ambient_temp",   limit: 24
    t.integer "humidity",       limit: 4
    t.float   "flow_rate",      limit: 24
  end

end
