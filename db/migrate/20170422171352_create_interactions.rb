class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.date     :date
      t.string   :method_of_contact
      t.string   :location
      t.text     :professional_discussion
      t.text     :casual_discussion
      t.text     :notes
      t.date     :follow_up
      t.text     :follow_up_topics
      t.integer  :connection_id

      t.timestamps null: false
    end
  end
end
