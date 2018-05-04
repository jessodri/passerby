class Profile < ApplicationRecord

  belongs_to :user
  validates :user, presence: true

  validates(
    :first_name,
    :last_name,
    :bio,
    :address_line_one,
    :city,
    :state,
    :postcode,
    :country_code,
    presence: true )

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    "#{address_line_one}#{address_line_two}, #{city}, #{state}, #{postcode}, #{country_code}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
