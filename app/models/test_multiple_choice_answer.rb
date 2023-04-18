class TestMultipleChoiceAnswer < ApplicationRecord
  validates :answer, :score, presence: true
  belongs_to :test_multiple_choice
end
