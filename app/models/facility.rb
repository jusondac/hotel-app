class Facility < ApplicationRecord
  belongs_to :room

  validates :description, presence: true
end
