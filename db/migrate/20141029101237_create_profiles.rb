class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :title
      t.integer :subcategory_id

      t.timestamps
    end
  end
end
