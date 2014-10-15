module Stats
  extend ActiveSupport::Concern

  def win_percentage(player_name)
     (games.wins_by(player_name.to_s.capitalize).count.to_f / games.count) * 100
  end

  def current_winner
    ['Paul', 'Oli'].sort_by do |player|
      win_percentage(player)
    end.last
  end
end
