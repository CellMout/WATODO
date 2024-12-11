class AddDoneToActivity < ActiveRecord::Migration[8.0]
  def change
    add_column :activities, :done, :boolean, default: false
  end
end
