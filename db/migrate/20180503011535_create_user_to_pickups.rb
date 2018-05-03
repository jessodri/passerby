class CreateUserToPickups < ActiveRecord::Migration[5.1]
  def change
    create_table :user_to_pickups do |t|
      t.references :user, foreign_key: true
      t.references :pickup_request, foreign_key: true
      t.timestamp :response_at
      t.boolean :accepted

      t.timestamps
    end
  end
end
