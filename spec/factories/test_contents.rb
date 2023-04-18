FactoryBot.define do
  factory :test_content do
    test
    association :testable, factory: :test_multiple_choice
  end
end
