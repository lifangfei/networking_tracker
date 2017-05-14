class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :company
      t.string   :title
      t.string   :phone
      t.string   :mobile
      t.string   :fax
      t.string   :email
      t.string   :website
      t.string   :industry
      t.string   :linkedin
      t.text     :notes
      t.integer  :tier
      t.integer  :list_id

      t.timestamps null: false
    end
  end
end
