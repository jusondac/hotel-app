class Room < ApplicationRecord
  belongs_to :room_type, optional: true
  belongs_to :inventory, optional: true
  has_many :facilities, dependent: :destroy
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
