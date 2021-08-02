FactoryBot.define do
  factory :receiver do
    sequence(:name) { |n| "Cool Receiver #{n}" }
    street { "456 Receiver Drive" }
    city { "Receiver Town" }
    state { "VT" }
    zip { "54321" }
  end
end