class TestContent < ApplicationRecord
  belongs_to :test
  belongs_to :testable , polymorphic: true
end
