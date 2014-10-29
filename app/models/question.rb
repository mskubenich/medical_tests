class Question < ActiveRecord::Base
  belongs_to :profile
  has_many :answers
end
