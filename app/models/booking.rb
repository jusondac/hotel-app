class Booking < ApplicationRecord
  belongs_to :room
  has_many :payments, dependent: :destroy

  validates :guest_name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  def extend_booking(new_end_date, payment_amount)
    if new_end_date > self.end_date
      self.end_date = new_end_date
      self.save
      self.payments.create(amount: payment_amount, payment_date: Date.today)
    else
      false
    end
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
