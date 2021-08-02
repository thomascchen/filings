FactoryBot.define do
  factory :filer do
    ein { "123" }
    sequence(:name) { |n| "Cool Filer #{n}" }
    street { "123 Filer Street" }
    city { "Filer Town" }
    state { "VT" }
    zip { "12345" }
  end
end