class ContestAnswer < ApplicationRecord
  validates :session_id, :question_id, :answer, presence: true
  belongs_to :session, class_name: 'ContestSession', foreign_key: 'session_id'
end
