class Game < ActiveRecord::Base
  belongs_to :weapon_set
  belongs_to :map
  has_many :players, through: :scores
  has_many :scores
  has_many :notes
  default_scope { includes(:scores) }

  accepts_nested_attributes_for :scores

  after_initialize :setup_scores

  # games pre-watershed were entered all at once and don't have valid dating/ordering
  WATERSHED = DateTime.civil(2014,8,19,00,21)

  class << self
    def total_score(games = nil)
      games = games.present? ? self.where(id: games.map(&:id)) : all

      Player.all.inject({}) do |hash, player|
        hash[player] = games.score_for(player)
        hash
      end
    end

    def score_for(player)
      joins(:scores).where(scores: {player: player}).sum(:score)
    end

    def no_notes
      joins('LEFT OUTER JOIN notes ON notes.game_id = games.id').where('notes.game_id IS NULL')
    end

    def since_watershed
      where(arel_table[:created_at].gteq(WATERSHED))
    end

    def draws
      all.select {|g| g.draw? }
    end

    def last_win
      (all - draws).last
    end

    def wins_by(player_name)
      player = Player.find_by_name(player_name)
      all.select {|g| g.winner == player }
    end

    def losses_by(player_name)
      player = Player.find_by_name(player_name)
      all.select {|g| g.loser == player }
    end

    def biggest_wins(count = 1)
      all.sort_by {|g| g.scores.order('score DESC').first.score - g.scores.order('score DESC').last.score }.last(count).reverse
    end
  end

  def note(body)
    notes.create(body: body)
  end

  def different_playing_session?(game)
    return false if game.blank?

    self.created_at > game.created_at + 30.minutes
  end

  def score(player_name)
    player = players.find_by_name(player_name)
    scores.where(player: player).first.score
  end

  def winner
    return nil if draw?
    scores.order('score DESC').first.player
  end

  def loser
    return nil if draw?
    scores.order('score DESC').last.player
  end

  def draw?
    scores.pluck(:score).uniq.count == 1
  end

  private
  def setup_scores
    if new_record? && scores.blank?
      [Player.find_by_name('Paul'), Player.find_by_name('Oli')].each do |p|
        scores.build(player: p)
      end
    end
  end
end
