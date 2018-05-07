class User < ApplicationRecord
  # after_create :create_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :profile
  has_many :pickup_requests
  has_many :conversations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 

  # def create_profile
  #   Profile.create!([
  #     {
  #     user_id: self.id
  #     }
  #   ])
  # end
end
