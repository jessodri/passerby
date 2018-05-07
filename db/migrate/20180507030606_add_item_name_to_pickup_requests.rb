class AddItemNameToPickupRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :pickup_requests, :item_name, :string
  end
end
