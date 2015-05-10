class Category < ActiveRecord::Base
  has_many :questions, dependent: :destroy

  serialize :session

  def generate_state
    self.points ||= 0 unless self.points
    self.session = [] unless self.session
  end

  def answered_questions_count
    self.session ? self.session.count : 0
  end
end
