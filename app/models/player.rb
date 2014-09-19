class Player < ActiveRecord::Base
  has_many :games, through: :scores
  has_many :scores

  def total_score
    scores.pluck(:score).sum
  end
end
