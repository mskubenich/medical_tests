class AddSessionToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :session, :text
  end
end
