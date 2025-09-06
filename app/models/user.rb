class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  belongs_to :role, optional: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  
  validates :email_address, presence: true, uniqueness: true
end
