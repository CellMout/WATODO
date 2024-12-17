class AddAddressToRequests < ActiveRecord::Migration[8.0]
  def change
    add_column :requests, :address, :string
  end
end
