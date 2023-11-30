class CreateOutfitLogsClothes < ActiveRecord::Migration[7.1]
  def change
    create_table :outfit_logs_clothes do |t|
      t.references :outfit_log, null: false, foreign_key: true
      t.references :cloth, null: false, foreign_key: true

      t.timestamps
    end
  end
end
