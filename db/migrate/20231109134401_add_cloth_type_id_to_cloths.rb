class AddClothTypeIdToCloths < ActiveRecord::Migration[7.1]
  def change
    add_column :cloths, :cloth_type_id, :integer
    remove_column :cloths, :type_name, :varchar
  end
end
