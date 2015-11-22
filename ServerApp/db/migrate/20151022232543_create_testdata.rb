class CreateTestdata < ActiveRecord::Migration
  def change
    create_table :testdata do |t|
      t.string :field1
      t.integer :field2

      t.timestamps null: false
    end
  end
end
