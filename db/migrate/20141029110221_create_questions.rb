class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :profile_id
      t.text :text

      t.timestamps
    end
  end
end
