class CreateClothGroupSelections < ActiveRecord::Migration[7.1]
  def change
    create_table :cloth_group_selections do |t|
      t.references :outfit_selection_rule, null: false, foreign_key: true
      t.references :cloth_group,           null: false, foreign_key: true
      t.integer    :selection_count,       null: false, default: 0

      t.timestamps
    end
  end
end
