class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :profile
  has_many :pickup_requests
  has_many :conversations
  has_many :user_to_pickups
  accepts_nested_attributes_for :user_to_pickups
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 
end
