class ChangeFloatsToDecimal < ActiveRecord::Migration[8.0]
  def change
    reversible do |dir|
      dir.up do
        # Table 'activities'
        change_column :activities, :latitude, :decimal, precision: 9, scale: 7
        change_column :activities, :longitude, :decimal, precision: 9, scale: 7

        # Table 'requests'
        change_column :requests, :lat, :decimal, precision: 9, scale: 7
        change_column :requests, :lon, :decimal, precision: 9, scale: 7
      end

      dir.down do
        # Revenir au type float
        change_column :activities, :latitude, :float
        change_column :activities, :longitude, :float

        change_column :requests, :lat, :float
        change_column :requests, :lon, :float
      end
    end
  end
end
