class RemoveProfileIdFromQuestion < ActiveRecord::Migration
  def change
    remove_column :questions, :profile_id
  end
end
