class UserToPickup < ApplicationRecord
  belongs_to :user
  belongs_to :pickup_request
  
end
