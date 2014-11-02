class AddUserIdToGameSession < ActiveRecord::Migration
  def change
    add_column :game_sessions, :user_id, :integer
  end
end
