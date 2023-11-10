class RemoveCategoryFromCloths < ActiveRecord::Migration[6.0]
  def change
    remove_column :clothes, :category, :integer
  end
end

