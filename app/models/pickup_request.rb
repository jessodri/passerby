class PickupRequest < ApplicationRecord
  include ImageUploader::Attachment.new(:image)

  belongs_to :user
  has_many :conversations
  # accepts_nested_attributes_for :user_to_pickups

  def price_in_dollars
    payment_amount.to_f / 100.0
   end
end
