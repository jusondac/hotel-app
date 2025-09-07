class Facility < ApplicationRecord
  belongs_to :room
  has_one :inventory, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :inventory, allow_destroy: true
end
