class RemoveSubcategories < ActiveRecord::Migration
  def up
    drop_table :subcategories
  end

  def down
    create_table :subcategories do |t|
      t.integer :category_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
