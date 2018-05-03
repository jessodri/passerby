class PickupRequest < ApplicationRecord
  belongs_to :user
  has_many :conversations
end
