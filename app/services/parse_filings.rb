class ParseFilings
  FILINGS = [
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
  ].freeze

  def self.call
    FILINGS.each do |url|
      uri = URI(url)
      xml_string = Net::HTTP.get(uri)
      xml_document = Nokogiri::XML(xml_string.squish)
      
      filer_fragment = Nokogiri::XML.fragment(xml_document.xpath("//irs:Return//irs:ReturnHeader//irs:Filer", "irs" => "http://www.irs.gov/efile"))
      
      filer = Filer.find_or_create_by!(
        ein: filer_fragment.at(".//EIN").text.squish,
        name: filer_fragment.at(".//*[contains(name(), 'Name')]").text.squish,
        street: filer_fragment.xpath(".//*[starts-with(name(), 'AddressLine')]").text.squish,
        city: filer_fragment.at(".//*[starts-with(name(),'City')]").text.squish,
        state: filer_fragment.at(".//*[starts-with(name(),'State')]").text.squish,
        zip: filer_fragment.at(".//*[starts-with(name(),'ZIP')]").text.squish
      )

      filing = Filing.create!(
        amended: xml_document.at("//irs:Return//irs:ReturnData//irs:IRS990//*[starts-with(name(),'Amended')]", "irs" => "http://www.irs.gov/efile").present?,
        tax_year: xml_document.at("//irs:Return//irs:ReturnHeader//*[starts-with(name(),'TaxY')]", "irs" => "http://www.irs.gov/efile").text.squish,
        url: url,
        xml: xml_document,
        filer: filer
      )
    
      receivers = xml_document.xpath("//irs:Return//irs:ReturnData//irs:IRS990ScheduleI/irs:RecipientTable", "irs" => "http://www.irs.gov/efile")
      
      receivers.each do |receiver|
        fragment = Nokogiri::XML.fragment(receiver)
    
        receiver = Receiver.find_or_create_by!(
          ein: fragment.at(".//*[contains(name(), 'EIN')]")&.text&.squish, # some receivers don't have an EIN
          name: fragment.at(".//*[contains(name(),'Name')]").text.squish,
          street: fragment.xpath(".//*[starts-with(name(), 'AddressLine')]").text.squish,
          city: fragment.at(".//*[starts-with(name(),'City')]").text.squish,
          state: fragment.at(".//*[starts-with(name(),'State')]").text.squish,
          zip: fragment.at(".//*[starts-with(name(),'ZIP')]").text.squish
        )
    
        Award.create!(
          cash_amount: fragment.at(".//*[contains(name(),'Cash')]").text.squish,
          purpose: fragment.at(".//*[contains(name(),'Purpose')]").text.squish,
          filer: filer,
          filing: filing,
          receiver: receiver
        )
      end
    end
  end
end