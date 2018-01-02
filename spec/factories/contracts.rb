FactoryBot.define do
  factory :contract do
    vendor "Vodafone"
    starts_on Date.yesterday
    ends_on Date.tomorrow
    price 29.99
    user
  end
end
