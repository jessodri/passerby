class PickupRequest < ApplicationRecord
  include ImageUploader::Attachment.new(:image)

  belongs_to :user
  has_many :conversations, dependent: :destroy
  has_one :user_to_pickup, dependent: :destroy
  accepts_nested_attributes_for :user_to_pickup

  validates( 
    :item_name,
    :description,
    :city,
    :state,
    :postcode,
    :country_code,
    :payment_amount,
    presence: true )

  geocoded_by :partial_pickup_address
  after_validation :geocode


  def self.search_by_pickup_address(search)
      where("LOWER(pickup_address) LIKE ?", "%#{search.downcase}%")
  end

  def partial_pickup_address
    "#{city}, #{state}, #{postcode}, #{country_code}"
  end

end
