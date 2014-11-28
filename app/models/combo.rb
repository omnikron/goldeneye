class Combo
  include Stats
  attr_accessor :map, :weapon_set, :games

  def self.top(count = 10)
    all.sort_by {|combo| combo.games.count }.reverse.first(count)
  end

  def self.all
    Map.all.map do |map|
      map.weapon_sets.uniq.map {|weapon_set| self.new(map, weapon_set) }
    end.flatten
  end

  def initialize(map, weapon_set)
    self.map        = map
    self.weapon_set = weapon_set
    self.games      = Game.where(map: map, weapon_set: weapon_set)
  end
end
