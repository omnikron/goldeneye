class Game < ActiveRecord::Base
  belongs_to :weapon_set
  belongs_to :map
  has_many :players, through: :scores
  has_many :scores
end
