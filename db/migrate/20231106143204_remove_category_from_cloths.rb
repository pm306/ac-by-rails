class RemoveCategoryFromCloths < ActiveRecord::Migration[6.0]
  def change
    remove_column :cloths, :category, :integer
  end
end

