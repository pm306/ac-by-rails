class CreateClothTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :cloth_types do |t|
      t.string :type_name, null: false
      t.string :category, default: 0, null: false

      t.timestamps
    end
    add_index :cloth_types, :type_name, unique: true #type_nameにユニーク制約
  end
end
