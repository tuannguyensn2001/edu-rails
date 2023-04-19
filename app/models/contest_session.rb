class ContestSession < ApplicationRecord
  validates :user_id, :test_id, :session_code, :status, presence: true
  belongs_to :user
  belongs_to :test
  has_many :answers, class_name: 'ContestAnswer', foreign_key: 'session_id'
end
