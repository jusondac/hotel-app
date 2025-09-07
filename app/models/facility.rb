class Facility < ApplicationRecord
  belongs_to :room
  has_one :inventory, dependent: :destroy

  validates :name, presence: true
end
