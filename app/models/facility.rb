class Facility < ApplicationRecord
  belongs_to :room_type
  belongs_to :inventory

  validates :description, presence: true
end
