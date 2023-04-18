FactoryBot.define do
  factory :test do
    name {Faker::Internet.name}
    time_to_do {Faker::Number.number(digits: 2)}
  end
end
