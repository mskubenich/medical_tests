class CreateGameSessions < ActiveRecord::Migration
  def change
    create_table :game_sessions do |t|
      t.integer :profile_id
      t.text :state

      t.timestamps
    end
  end
end
