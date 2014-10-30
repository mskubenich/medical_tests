class GameSession < ActiveRecord::Base
  belongs_to :profile

  serialize :state

  def generate_state
    return self.state unless self.state.blank?

    self.state = {}
    self.profile.questions.pluck(:id).each do |id|
      self.state[id] = {}
    end
  end
end
