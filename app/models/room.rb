class Room < ApplicationRecord
  has_many :facilities, dependent: :destroy
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :room_type, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
