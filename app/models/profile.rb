class Profile < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :game_sessions, dependent: :destroy
  belongs_to :subcategory
end