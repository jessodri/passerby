class AddLocationFieldsToPickupRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :pickup_requests, :city, :string
    add_column :pickup_requests, :state, :string
    add_column :pickup_requests, :postcode, :string
    add_column :pickup_requests, :country_code, :string
    add_column :pickup_requests, :latitude, :string
    add_column :pickup_requests, :longitude, :string
  end
end
