class Player < ActiveRecord::Base
  has_many :games, through: :scores
  has_many :scores
end
