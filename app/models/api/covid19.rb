class Api::Covid19
  API_BASE_URL = "https://opendata.corona.go.jp/api/Covid19JapanAll"
  def self.find_by_name(prefecture_name)
    self.api_request(prefecture_name, 0)
  end

  private

  def self.api_request(prefecture_name, count = 0)
    uri = URI(API_BASE_URL)
    params = { dataName: prefecture_name }
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    response.is_a?(Net::HTTPSuccess) ? JSON.parse(response.body)["itemList"][0] : nil
  rescue StandardError
    return nil if count > 3

    count += 1
    sleep(0.2)
    self.api_request(prefecture_name, count)
  end
end
