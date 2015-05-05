class Category < ActiveRecord::Base
  has_many :profiles, dependent: :destroy
end
