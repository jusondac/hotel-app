class Facility < ApplicationRecord
  belongs_to :room, optional: true
  belongs_to :room_type, optional: true

  validates :name, presence: true
end
