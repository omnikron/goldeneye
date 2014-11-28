class Map < ActiveRecord::Base
  include Stats

  has_many :games
  has_many :weapon_sets, through: :games

  def self.popularity
    joins(:games).group("games.map_id").order("count(games.map_id) desc")
  end
end
