class CreateDatabase ActiveRecord::Migration
	def change
	#def self.up
	  create_table "testdata", force: :cascade do |t|
	    t.string   "field1",     limit: 255
	    t.integer  "field2",     limit: 4
	    t.datetime "created_at",             null: false
	    t.datetime "updated_at",             null: false
	  end
	end

	#def self.down
		#
	#end
end