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

puts "Creating filings..."

filing_urls.each do |url|
  uri = URI(url)
  xml_string = Net::HTTP.get(uri)
  xml_document = Nokogiri::XML(xml_string.squish)
  
  filer_fragment = Nokogiri::XML.fragment(xml_document.xpath("//irs:Return//irs:ReturnHeader//irs:Filer", "irs" => "http://www.irs.gov/efile"))
  filer = Filer.create_with(
    name: filer_fragment.at(".//*[contains(name(), 'Name')]").text.squish,
  ).find_or_create_by!(ein: filer_fragment.at(".//EIN").text.squish)
  filer_address = Address.find_or_create_by!(
    street: filer_fragment.xpath(".//*[starts-with(name(), 'AddressLine')]").text.squish,
    city: filer_fragment.at(".//*[starts-with(name(),'City')]").text.squish,
    state: filer_fragment.at(".//*[starts-with(name(),'State')]").text.squish,
    zip: filer_fragment.at(".//*[starts-with(name(),'ZIP')]").text.squish
  )

  filing = Filing.create!(url: url, xml: xml_document, filer: filer, filer_address: filer_address)

  receivers = xml_document.xpath("//irs:Return//irs:ReturnData//irs:IRS990ScheduleI/irs:RecipientTable", "irs" => "http://www.irs.gov/efile")
  receivers.each do |receiver|
    fragment = Nokogiri::XML.fragment(receiver)

    receiver_address = Address.find_or_create_by!(
      street: fragment.xpath(".//*[starts-with(name(), 'AddressLine')]").text.squish,
      city: fragment.at(".//*[starts-with(name(),'City')]").text.squish,
      state: fragment.at(".//*[starts-with(name(),'State')]").text.squish,
      zip: fragment.at(".//*[starts-with(name(),'ZIP')]").text.squish
    )

    receiver = if fragment.at(".//*[contains(name(), 'EIN')]")
      Receiver.create_with(
        name: fragment.at(".//*[contains(name(),'Name')]").text.squish,
      ).find_or_create_by!(ein: fragment.at(".//*[contains(name(), 'EIN')]").text.squish)
    else
      Receiver.find_or_create_by!(name: fragment.at(".//*[contains(name(),'Name')]").text.squish)
    end

    Award.create!(
      cash_amount: fragment.at(".//*[contains(name(),'Cash')]").text.squish,
      purpose: fragment.at(".//*[contains(name(),'Purpose')]").text.squish,
      filer: filer,
      filing: filing,
      receiver: receiver,
      receiver_address: receiver_address
    )
  end
end

puts "#{Filing.count} filings created!"
puts "#{Filer.count} filers created!"
puts "#{Address.count} addresses created!"
puts "#{Receiver.count} receivers created!"
puts "#{Award.count} awards created!"
