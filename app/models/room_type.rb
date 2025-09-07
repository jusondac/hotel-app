class RoomType < ApplicationRecord
  has_many :rooms, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
