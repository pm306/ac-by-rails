class AddClothTypeIdToCloths < ActiveRecord::Migration[7.1]
  def change
<<<<<<< HEAD
    add_column :clothes, :cloth_type_id, :integer
    remove_column :clothes, :type_name, :varchar
=======
    unless column_exists?(:clothes, :cloth_type_id)
      add_column :clothes, :cloth_type_id, :integer
    end

    if column_exists?(:clothes, :type_name)
      remove_column :clothes, :type_name
    end
>>>>>>> bugfix-docker
  end
end
