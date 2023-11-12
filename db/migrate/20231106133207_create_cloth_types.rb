class CreateClothTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :cloth_types do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :cloth_types, :name, unique: true #type_nameにユニーク制約
  end
end
