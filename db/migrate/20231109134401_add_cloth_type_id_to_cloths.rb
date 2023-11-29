class AddClothTypeIdToCloths < ActiveRecord::Migration[7.1]
  def change
    add_column :clothes, :cloth_type_id, :integer
    remove_column :clothes, :type_name, :varchar
  end
end
