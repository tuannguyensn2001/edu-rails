class TestMultipleChoice < ApplicationRecord
  validates :file_path, :score, presence: true

  has_many :test_multiple_choice_answers, dependent: :destroy
  has_one :test_content, as: :testable
end
