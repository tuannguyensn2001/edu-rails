class Test < ApplicationRecord
  validates :name , uniqueness: true, presence: true
  validates :time_to_do, presence: true

  has_one :test_content
end
