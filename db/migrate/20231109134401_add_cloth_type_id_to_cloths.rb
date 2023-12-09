class AddClothTypeIdToCloths < ActiveRecord::Migration[7.1]
  def change
    add_column :clothes, :cloth_type_id, :integer unless column_exists?(:clothes, :cloth_type_id)

    return unless column_exists?(:clothes, :type_name)

    remove_column :clothes, :type_name
  end
end
