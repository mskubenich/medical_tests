class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.integer :category_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
