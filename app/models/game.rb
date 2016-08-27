class Game < ActiveRecord::Base
  belongs_to :weapon_set
  belongs_to :map
  has_many :players, through: :scores
  has_many :scores
  has_many :notes

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
      joins(:scores).where(scores: {player: player}).sum('scores.score')
    end

    def no_notes
      joins('LEFT OUTER JOIN notes ON notes.game_id = games.id').where('notes.game_id IS NULL')
    end

    def since_watershed
      where(arel_table[:created_at].gteq(WATERSHED))
    end

    def draws
      where("(SELECT COUNT (DISTINCT score) FROM scores WHERE game_id = games.id) = 1").distinct
    end

    def wins
      where("(SELECT COUNT (DISTINCT score) FROM scores WHERE game_id = games.id) != 1").distinct
    end

    def last_win
      wins.last
    end

    def wins_by(player)
      wins.where("(SELECT player_id FROM scores WHERE scores.game_id = games.id ORDER BY score DESC LIMIT 1) = ?", player.id)
    end

    def losses_by(player)
      wins.where("(SELECT player_id FROM scores WHERE scores.game_id = games.id ORDER BY score ASC LIMIT 1) = ?", player.id)
    end

    def biggest_wins(count = 1)
      joins(:scores).order("( SELECT score FROM scores WHERE scores.game_id = games.id ORDER BY score DESC LIMIT 1) - (SELECT score FROM scores WHERE scores.game_id = games.id ORDER BY score ASC limit 1) DESC").limit(count)
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
    scores.joins(:player).where(players: { name: player_name }).first.score
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
    if draw == nil && persisted?
      is_draw = Game.draws.exists?(self)
      self.update_attribute(:draw, is_draw)
    else
      draw
    end
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
