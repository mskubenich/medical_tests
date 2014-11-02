class GameSessionsController < ApplicationController
  def index
    @games = GameSession.where user_id: current_user.id
  end
end
