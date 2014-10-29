class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :profiles, dependent: :destroy
end
