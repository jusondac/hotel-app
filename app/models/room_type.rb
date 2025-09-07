class RoomType < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :facilities, dependent: :destroy
  accepts_nested_attributes_for :facilities, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
