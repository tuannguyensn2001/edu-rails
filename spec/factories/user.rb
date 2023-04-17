FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username(specifier: 6..8) }
    password { Faker::Internet.password(min_length: 10) }
  end
end