FactoryBot.define do
  factory :award do
    sequence(:cash_amount) { |n| 1000 + n }
    purpose { "General Operations" }
    filer
    filing
    receiver
  end
end