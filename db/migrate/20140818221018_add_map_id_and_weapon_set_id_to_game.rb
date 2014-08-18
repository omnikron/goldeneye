class AddMapIdAndWeaponSetIdToGame < ActiveRecord::Migration
  def change
    add_column :games, :map_id, :integer
    add_column :games, :weapon_set_id, :integer
  end
end
