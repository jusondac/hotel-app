class RoomType < ApplicationRecord
  has_many :facilities, dependent: :destroy
  has_many :rooms, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  accepts_nested_attributes_for :facilities, allow_destroy: true, reject_if: :all_blank
end
