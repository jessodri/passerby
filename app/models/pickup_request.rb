class PickupRequest < ApplicationRecord
  # include ImageUploader::Attachment.new(:image)

  belongs_to :user
  has_many :conversations
end
