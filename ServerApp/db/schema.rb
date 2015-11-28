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

  create_table "Admin", primary_key: "username", force: :cascade do |t|
    t.string "password_digest", limit: 60
  end

  create_table "Contact", id: false, force: :cascade do |t|
    t.string "first_name",   limit: 30, default: "", null: false
    t.string "last_name",    limit: 30, default: "", null: false
    t.string "phone_number", limit: 11
    t.string "email",        limit: 40
  end

  create_table "SensorData", id: false, force: :cascade do |t|
    t.datetime "time_recorded",                        null: false
    t.integer  "sensor_id",     limit: 4,  default: 0, null: false
    t.float    "value",         limit: 24
  end

  add_index "sensordata", ["sensor_id"], name: "sensor_id", using: :btree

  create_table "Sensors", primary_key: "sensor_id", force: :cascade do |t|
    t.string  "sensor_type", limit: 15
    t.integer "update_rate", limit: 4
  end

  add_foreign_key "SensorData", "Sensors", column: "sensor_id", primary_key: "sensor_id", name: "sensordata_ibfk_1"
end
