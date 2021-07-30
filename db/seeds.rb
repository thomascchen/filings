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
  
  Filing.create!(url: url, data: xml_document)
  
  filer_fragment = Nokogiri::XML.fragment(xml_document.xpath("//irs:Return//irs:ReturnHeader//irs:Filer", "irs" => "http://www.irs.gov/efile"))
  filer_attributes = {
    ein: filer_fragment.at(".//EIN").text.squish,
    name: filer_fragment.at(".//*[contains(name(), 'Name')]").text.squish,
    address: filer_fragment.xpath(".//*[starts-with(name(), 'AddressLine')]").text.squish,
    city: filer_fragment.at(".//*[starts-with(name(),'City')]").text.squish,
    state: filer_fragment.at(".//*[starts-with(name(),'State')]").text.squish,
    zip: filer_fragment.at(".//*[starts-with(name(),'ZIP')]").text.squish
  }
  Filer.create_with(
    name: filer_attributes[:name],
    address: filer_attributes[:address],
    city: filer_attributes[:city],
    state: filer_attributes[:state],
    zip: filer_attributes[:zip]
  ).find_or_create_by(ein: filer_attributes[:ein])

  puts filer_attributes
end

puts "Filings seeded!"
