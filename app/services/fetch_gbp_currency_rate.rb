class FetchGbpCurrencyRate
  CACHE_KEY = "GBP_CURRENCY_RATE".freeze

  def self.call
    Rails.cache.fetch(CACHE_KEY, expires_in: 1.minute, skip_nil: true) do
      url = URI("https://freecurrencyapi.net/api/v1/rates?base_currency=USD")
      
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      request = Net::HTTP::Get.new(url)
      request["accept"] = "application/json"
      request["content-type"] = "application/json"
      request["apikey"] = ENV['FREE_CURRENCY_API_KEY']
      
      response = http.request(request)

      JSON.parse(response.read_body)["data"].values.first["GBP"]
    end
  end
end
