class GameSession < ActiveRecord::Base
  belongs_to :profile
  belongs_to :user

  serialize :state

  def generate_state
    return self.state unless self.state.blank?

    self.state = {}
    self.profile.questions.pluck(:id).each do |id|
      self.state[id] = {}
    end
  end

  def available_questions
    self.state.select{ |k, v| !v[:success].present? }
  end

  def available_questions_count
    available_questions.keys.count
  end

  def correct_answered_questions_count
    self.state.select{ |k, v| v[:success] == 'true' }.keys.count
  end
end
