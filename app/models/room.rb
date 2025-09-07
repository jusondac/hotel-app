class Room < ApplicationRecord
  belongs_to :room_type
  has_many :bookings, dependent: :destroy

  validates :name, presence: true

  # Delegate facilities to room_type
  delegate :facilities, to: :room_type
  delegate :price, to: :room_type
end
