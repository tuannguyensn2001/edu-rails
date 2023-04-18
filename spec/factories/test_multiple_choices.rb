FactoryBot.define do
  factory :test_multiple_choice do
    file_path {Faker::Internet.name}
    score {10}
  end
end
