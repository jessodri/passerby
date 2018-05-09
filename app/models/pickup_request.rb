class PickupRequest < ApplicationRecord
  include ImageUploader::Attachment.new(:image)

  belongs_to :user
  has_many :conversations
  has_one :user_to_pickup, dependent: :destroy
  accepts_nested_attributes_for :user_to_pickup

  def price_in_dollars
    payment_amount.to_f / 100.0
  end

  def self.search_by_pickup_address(search)
      where("LOWER(pickup_address) LIKE ?", "%#{search.downcase}%")
  end

end
