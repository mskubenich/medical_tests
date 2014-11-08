class MoveGameSessionToProfile < ActiveRecord::Migration
  def up
    Profile.all.each do |p|
      p.session = p.game_session.state if p.game_session
      p.save
    end
  end

  def down

  end
end
