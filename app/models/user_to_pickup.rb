class UserToPickup < ApplicationRecord
  belongs_to :user
  belongs_to :pickup_request
  validates :pickup_request_id, uniqueness: { message: 'Only one user can accept a pickup request.' }

  # validates :, uniqueness: { scope: : }
  # validates :user_to_pickup_id, uniqueness: { scope: :user_id, message: "You've already accepted this request!" }

end
