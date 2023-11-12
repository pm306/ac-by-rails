class CreateClothGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :cloth_groups do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
    add_index :cloth_groups, :name, unique: true
  end
end
