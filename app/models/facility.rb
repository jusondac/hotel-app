class Facility < ApplicationRecord
  belongs_to :room
  belongs_to :inventory

  validates :description, presence: true
end
