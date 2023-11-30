class AddDeletedAtToCloths < ActiveRecord::Migration[7.1]
  def change
    add_column :clothes, :deleted_at, :datetime
  end
end
