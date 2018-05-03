class CreatePickupRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :pickup_requests do |t|
      t.string :pickup_address
      t.text :description
      t.text :image_data
      t.string :delivery_address
      t.decimal :payment_amount
      t.decimal :stripe_charge_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
