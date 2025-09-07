class Inventory < ApplicationRecord
  has_many :facilities, dependent: :destroy

  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
