class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :costumes, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many_attached :photos
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
