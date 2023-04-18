FactoryBot.define do
  factory :contest_session do
    user
    test
    session_code { SecureRandom.uuid }
    status { "START" }
  end
end
