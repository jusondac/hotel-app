class Payment < ApplicationRecord
  belongs_to :booking

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :payment_date, presence: true
end
