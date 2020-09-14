class User < ApplicationRecord
  before_save { self.email = email.downcase } # Lo settea a dowcase antes de guardarlo
  has_many :articles  # One to Many Side, FK
  has_secure_password # bcrypt Salt Encryption

  # Constraints al user
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :username, uniqueness: { case_sensitive: false }, presence: true, length: { minimum: 3, maximum: 25 }

  validates :email, uniqueness: { case_sensitive: false }, presence: true, length: { maximum: 105 }, format: { with: VALID_EMAIL_REGEX }
end
