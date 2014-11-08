class Profile < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  belongs_to :subcategory
  has_one :game_session


  serialize :session

  def generate_state
    return self.session unless self.session.blank?

    self.session = {}
    self.questions.pluck(:id).each do |id|
      self.session[id] = {}
    end
  end

  def available_questions
    self.session.select{ |k, v| !v[:success].present? }
  end

  def available_questions_count
    available_questions.keys.count
  end

  def correct_answered_questions_count
    self.session.select{ |k, v| v[:success] == 'true' }.keys.count
  end
end