class AddNameToWeaponSets < ActiveRecord::Migration
  def change
    add_column :weapon_sets, :name, :string
  end
end
