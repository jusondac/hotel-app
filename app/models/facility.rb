class Facility < ApplicationRecord
  belongs_to :room, optional: true
  belongs_to :room_type, optional: true
  has_one :inventory, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :inventory, allow_destroy: true
end
