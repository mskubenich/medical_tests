class Profile < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  belongs_to :subcategory
end