require 'answer'

class Question < ActiveRecord::Base
  belongs_to :category
  after_initialize :set_default_answers
  serialize :answers

  private

  def set_default_answers
    self.answers ||= []
  end
end
