class WeaponSet < ActiveRecord::Base
  has_many :games

  def self.popularity
    joins(:games).group("games.weapon_set_id").order("count(games.weapon_set_id) desc")
  end
end
