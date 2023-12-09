class CreateClothes < ActiveRecord::Migration[7.1]
  def change
    create_table :clothes do |t|
      t.integer :user_id, null: false
      t.text :description
      t.date :last_worn_on, null: false # 一度も着ていない場合は古い日付にする

      t.timestamps
    end
    add_index :clothes, :user_id
  end
end
