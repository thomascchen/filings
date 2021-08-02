FactoryBot.define do
  factory :filing do
    sequence(:tax_year) { |n| 2021 - n }
    url { "url" }
    xml { Nokogiri::XML("<xml></xml>") }
    filer
  end
end