class Costume < ApplicationRecord
  CATEGORY = ["Renaissance", "Antiquite & Moyen-Age", "XVIIesiecle", "XVIIIesiecle", "XIXesiecle", "XXesiecle", "Contemporain", "Uniformes"]

  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  validates :category, inclusion: { in: CATEGORY }
end
