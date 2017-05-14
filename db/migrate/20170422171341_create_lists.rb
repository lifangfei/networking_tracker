class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string   :name
      t.integer  :tier
      t.text     :notes
      t.integer  :user_id

      t.timestamps null: false
    end
  end
end
