class RemoveProfile < ActiveRecord::Migration
  def up
    drop_table :profiles
  end

  def down
    create_table :profiles do |t|
      t.string :title
      t.integer :category_id

      t.timestamps
    end
  end
end
