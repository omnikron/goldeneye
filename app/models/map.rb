class Map < ActiveRecord::Base
  has_many :games

  def self.popularity
    joins(:games).group("games.map_id").order("count(games.map_id) desc")
  end
end
