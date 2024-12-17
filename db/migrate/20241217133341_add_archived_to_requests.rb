class AddArchivedToRequests < ActiveRecord::Migration[8.0]
  def change
    add_column :requests, :archived, :boolean, default: false
  end
end
