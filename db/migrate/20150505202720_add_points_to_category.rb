class AddPointsToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :points, :integer
  end
end
