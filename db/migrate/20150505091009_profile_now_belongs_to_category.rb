class ProfileNowBelongsToCategory < ActiveRecord::Migration
  def change
    remove_column :profiles, :subcategory_id
    add_column :profiles, :category_id, :integer
  end
end
