class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.text :image_data
      t.string :address_line_one
      t.string :address_line_two
      t.string :city
      t.string :state
      t.string :postcode
      t.string :country_code
      t.string :latitude
      t.string :longitude
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
