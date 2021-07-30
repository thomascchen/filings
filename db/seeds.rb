# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

filing_urls = [
  "http://s3.amazonaws.com/irs-form-990/201132069349300318_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201612429349300846_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201521819349301247_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201641949349301259_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201921719349301032_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201831309349303578_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201823309349300127_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201401839349300020_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201522139349100402_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201831359349101003_public.xml"
]

puts "Seeding filings..."

filing_urls.each do |url|
  uri = URI(url)
  xml_string = Net::HTTP.get(uri)
  xml_document = Nokogiri::XML(xml_string.squish)

  Filing.create(url: url, data: xml_document)
end

puts "Filings seeded!"
