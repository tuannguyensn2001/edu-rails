FactoryBot.define do
  factory :test_multiple_choice do
    file_path { Faker::Internet.name }
    score { 10 }
    # test_content { create(:test_content, testable: create(:test_multiple_choice_content)) }

    after(:build) do |test|
      test.test_multiple_choice_answers = build_list(:test_multiple_choice_answer, 3)
    end

  end
end
