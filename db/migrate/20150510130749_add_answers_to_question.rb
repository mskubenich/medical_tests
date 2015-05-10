class AddAnswersToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :answers, :text
  end
end
