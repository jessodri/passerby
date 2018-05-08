class PickupRequest < ApplicationRecord
  include ImageUploader::Attachment.new(:image)

  belongs_to :user
  has_many :conversations
  # accepts_nested_attributes_for :user_to_pickups
end
