class Api::Covid19
  API_BASE_URL = "https://opendata.corona.go.jp/api/Covid19JapanAll".freeze
  DEFAULT_COUNT = 0
  def self.find_by(prefecture_name: User::DEFUALT_PREFECTURE)
    response = api_request(prefecture_name, DEFAULT_COUNT)
    response[0]
  end

  def self.find_by_previous_day_ratio(prefecture_name: User::DEFUALT_PREFECTURE)
    response = api_request(prefecture_name, DEFAULT_COUNT)
    response[0]["npatients"].to_i - response[1]["npatients"].to_i
  end

  def self.all(prefecture_name: User::DEFUALT_PREFECTURE)
    api_request(prefecture_name, DEFAULT_COUNT)
  end

  def self.api_request(prefecture_name, count = DEFAULT_COUNT)
    uri = URI(API_BASE_URL)
    params = { dataName: prefecture_name }
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(uri)
    response.is_a?(Net::HTTPSuccess) ? JSON.parse(response.body)["itemList"] : nil
  rescue StandardError
    return nil if count > 3

    count += 1
    sleep(0.2)
    api_request(prefecture_name, count)
  end
end
