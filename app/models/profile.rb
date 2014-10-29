class Profile < ActiveRecord::Base
  has_many :questions
end