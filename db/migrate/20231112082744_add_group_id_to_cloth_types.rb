class AddGroupIdToClothTypes < ActiveRecord::Migration[7.1]
  def change
    add_reference :cloth_types, :cloth_group, foreign_key: true
  end
end
