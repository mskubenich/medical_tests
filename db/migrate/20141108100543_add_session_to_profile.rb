class AddSessionToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :session, :text
  end
end
