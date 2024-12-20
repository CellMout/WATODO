class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.string :location
      t.references :request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
