class RemovePasswordFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :password, :string # カラムの型はもとのpasswordカラムの型に合わせてください
  end
end
