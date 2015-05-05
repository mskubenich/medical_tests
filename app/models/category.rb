class Category < ActiveRecord::Base
  has_many :profiles, dependent: :destroy
  has_many :questions, dependent: :destroy
end
