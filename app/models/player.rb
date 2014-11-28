class Player < ActiveRecord::Base
  has_many :games, through: :scores
  has_many :scores

  def total_score
    scores.pluck(:score).sum
  end

  def longest_streaks(count = 1)
    streaks.sort_by {|streak| streak.length }.last(count)
  end

  def streaks
    post_watershed_games.no_notes.inject([]) do |streaks, game|
      streaks << [] if streaks.empty?
      streak = streaks[-1]
      if game.winner == self || game.draw?
        streak << game
      else
        streaks << [] if streaks[-1].present?
      end
      streaks
    end
  end

  def post_watershed_games
    games.since_watershed.includes(:scores, :players).order('created_at ASC')
  end
end
