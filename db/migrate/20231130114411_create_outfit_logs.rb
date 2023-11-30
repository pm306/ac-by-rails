class CreateOutfitLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :outfit_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
