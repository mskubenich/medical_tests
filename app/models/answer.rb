class Answer
  attr_accessor :question_id, :text, :points, :id, :errors

  def initialize(options)
    self.question_id = options[:question_id]
    self.text = options[:text]
    self.points = options[:points]
  end

  def question
    Question.find self.question_id
  end

  def set_id
    self.id = self.question.answers.map(&:id).push(0).compact.max + 1
  end
end