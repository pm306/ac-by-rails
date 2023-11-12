class CreateOutfitSelectionRules < ActiveRecord::Migration[7.1]
  def change
    create_table :outfit_selection_rules do |t|
      t.string :name, null: false
      t.text :description
      t.integer :priority, null: false
      t.float :min_temperature_lower_bound
      t.float :min_temperature_upper_bound
      t.float :max_temperature_lower_bound
      t.float :max_temperature_upper_bound

      t.timestamps
    end
    add_index :outfit_selection_rules, :name, unique: true
  end
end
