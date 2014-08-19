class Game < ActiveRecord::Base
  belongs_to :weapon_set
  belongs_to :map
  has_many :players, through: :scores
  has_many :scores
  has_many :notes

  accepts_nested_attributes_for :scores

  after_initialize :setup_scores, on: :create

  def note(body)
    notes.create(body: body)
  end

  def score(player_name)
    player = players.find_by_name(player_name)
    scores.where(player: player).first.score
  end

  private
  def setup_scores
    [Player.find_by_name('Paul'), Player.find_by_name('Oli')].each do |p|
      scores.build(player: p)
    end
  end
end
