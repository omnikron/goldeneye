module Stats
  extend ActiveSupport::Concern

  def win_percentage(player)
     (games.wins_by(player).count.to_f / games.count) * 100
  end

  def current_winner
    Player.all.sort_by do |player|
      win_percentage(player)
    end.last
  end
end
