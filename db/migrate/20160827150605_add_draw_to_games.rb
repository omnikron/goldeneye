class AddDrawToGames < ActiveRecord::Migration
  def change
    add_column :games, :draw, :boolean
  end
end
