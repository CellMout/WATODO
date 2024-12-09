class CreateRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :duration
      t.float :lat
      t.float :lon
      t.string :options
      t.string :category

      t.timestamps
    end
  end
end
