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
  
  def state
    self.generate_state
    self.save
    questions_count = self.questions.count
    finished_questions_count = self.answered_questions_count
    points = self.points.to_i
    available_points = questions_count * 100
    finished_questions_percentage = ((finished_questions_count * 100.0)/questions_count).round(1)

    {
        questions_count:          questions_count,
        finished_questions_count: finished_questions_count,
        points:  points,
        available_points:  available_points,
        finished_questions_percentage: finished_questions_percentage
    }
  end
end
