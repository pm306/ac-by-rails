class CreateOutfitSelectionRules < ActiveRecord::Migration[7.1]
  def change
    create_table :outfit_selection_rules do |t|
      t.integer :min_temperature_lower_bound
      t.integer :min_temperature_upper_bound
      t.integer :max_temperature_lower_bound
      t.integer :max_temperature_upper_bound
      t.integer :priority, null: false
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
