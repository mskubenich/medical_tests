module ProfilesHelper
  def available_questions
    @game.state.select{ |k, v| !v[:success].present? }.keys
  end
end
