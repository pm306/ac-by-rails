class ChangeCategoryTypeInClothTypes < ActiveRecord::Migration[7.1]
  def change
    change_column :cloth_types, :category, :integer
  end
end
