require "bcrypt"

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :username,:password , presence: true, length: { minimum: 6 }
  include BCrypt

end
