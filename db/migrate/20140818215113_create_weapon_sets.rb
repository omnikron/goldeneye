class CreateWeaponSets < ActiveRecord::Migration
  def change
    create_table :weapon_sets do |t|

      t.timestamps
    end
  end
end
